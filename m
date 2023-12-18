Return-Path: <linux-kernel+bounces-4163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0038178AC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 210071F24212
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A5E5D726;
	Mon, 18 Dec 2023 17:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1idzLJF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BFD498B7;
	Mon, 18 Dec 2023 17:28:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AA8C433C7;
	Mon, 18 Dec 2023 17:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702920495;
	bh=vwrl1pDVKX3UhF1iN/1SsAJqfg8Jw0RWC9zVOH+2bi8=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Y1idzLJFNjREKXSIes3/KLE2InfMkMdkIDs58SpzvJ8PtsS7n8yQ93gDtF1ROEglo
	 xgdvR42+9IJCR5iB1PabGXxKiy0OD0gJGgyym9mF+xCOqLBamcDS2LufxedHtiu2cY
	 L8rm6cjQ3pUaQ8a26zgKyhEMdSUafUOabxYeAtadKGI0o3aOPTlN0hVJZYcOV+of2V
	 lVF27r8qYCwABjmFFpCrcBfBAeUUkVg/YU7wfHi/xib/15oBLQxWEu3D+xWkkChk5U
	 A81n6U5u/NIxrZLamnBF0Y3ZX7zv+YQkJ27QDfUkIU0MLuItV4x09GZAJ7167PHlj0
	 6Zt1WgYLsu9oA==
From: Mark Brown <broonie@kernel.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231211123104.72963-1-krzysztof.kozlowski@linaro.org>
References: <20231211123104.72963-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/4] ASoC: dt-bindings: qcom,lpass-rx-macro: Add
 X1E80100 LPASS RX
Message-Id: <170292049267.89121.1314873749419554799.b4-ty@kernel.org>
Date: Mon, 18 Dec 2023 17:28:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Mon, 11 Dec 2023 13:31:01 +0100, Krzysztof Kozlowski wrote:
> Add bindings for Qualcomm X1E80100 SoC Low Power Audio SubSystem (LPASS)
> RX macro codec, which looks like compatible with earlier SM8550.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: dt-bindings: qcom,lpass-rx-macro: Add X1E80100 LPASS RX
      commit: 2f4734f3f48fff9437e4d38531c699b0a62ff8a8
[2/4] ASoC: dt-bindings: qcom,lpass-rx-macro: Add X1E80100 LPASS TX
      commit: 7de2109ce1619951e957eaafab83545a4cab8609
[3/4] ASoC: dt-bindings: qcom,lpass-rx-macro: Add X1E80100 LPASS VA
      commit: f990306adf2715cc2bdb85470065f7326a42081b
[4/4] ASoC: dt-bindings: qcom,lpass-rx-macro: Add X1E80100 LPASS WSA
      commit: 173a3b20a4980265bab52dbc60b616e739664b0d

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


