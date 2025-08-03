[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/duarteocarmo/deepseek-agents-workshop) [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/duarteocarmo/deepseek-agents-workshop/HEAD)

# Workshop: Agentic AI with DeepSeek

This is a tutorial about building agents with DeepSeek. The goal is to give you a brief introduction to agents and how you can build production ready agents with DeepSeek. 

## Setup 

1. Clone the repo:
   ```
   git clone git@github.com:duarteocarmo/deepseek-agents-workshop.git
   ```
2. Make sure you have [uv](https://docs.astral.sh/uv/getting-started/installation/) installed. If not, install it.
3. Change directory to the project:
   ```
   cd deepseek-agents-workshop
   ```
4. Sync dependencies:
   ```
   uv sync
   ```
5. Activate the virtual environment:

   - On Windows, activate the virtual environment:
     ```
     .venv\Scripts\activate
     ```
   - On macOS/Linux, activate the virtual environment:
     ```
     source .venv/bin/activate
     ```
6. Set up your DeepSeek API key:
   - Visit https://platform.deepseek.com
   - Set up billing
   - Create a new API key
   - Add the API key to the `.envrc` file as `DEEPSEEK_API_KEY=sk-XXXXXXX`

7. Open your IDE (for example, VS Code or Cursor):
   ```
   code .
   ```
8. Open the `00-welcome.ipynb` notebook in your IDE.

9. Run the notebook to verify your environment is set up correctly.
