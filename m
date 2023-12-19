Return-Path: <linux-kernel+bounces-5536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD64818BD2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67AA628781D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0126D1D54B;
	Tue, 19 Dec 2023 16:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sl0irgBN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AC020B34;
	Tue, 19 Dec 2023 16:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB48C433C7;
	Tue, 19 Dec 2023 16:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703001951;
	bh=wOOLPNOS6Wdenq2YMCXYX637AGsdeEONrDQ0EipOGM0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Sl0irgBN4Po4Qo20Sl0qGNtmJUhnIP3EOb9EMDDVocMhShoFeDVV0QQjBnuj0WRV1
	 7CNzsJfUF5ko4jAlf4w8z1GQXPTszA/y6uiE1UNsmLdE1LTk//Sdde1y8ERaHcnDQc
	 vtqmuhTKbMIajlLoXP2O2o2yeIkK80AvhMpvTTPWCYgYZBYJeg+TLx4+7l33mHP4j+
	 O6X/WjNl/sLr8gyQcmohEyDEYQxUc+ReXcYzjTFB3hblT0iMKtyaxLQHEuOCl9je6F
	 SHTqo/fkTnt9cUdKMroaun13XvBrVfQaqdJ2ONw14x0fV95e9UCJ/dwN+QZzgs5+hq
	 pq9YE9EhtZQDA==
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
In-Reply-To: <20231219075749.25308-1-johan+linaro@kernel.org>
References: <20231219075749.25308-1-johan+linaro@kernel.org>
Subject: Re: [PATCH] dt-bindings: regulator: qcom,usb-vbus-regulator: clean
 up example
Message-Id: <170300194921.59203.15876137715050350812.b4-ty@kernel.org>
Date: Tue, 19 Dec 2023 16:05:49 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Tue, 19 Dec 2023 08:57:49 +0100, Johan Hovold wrote:
> Devicetree node names should be generic; fix up the
> qcom,usb-vbus-regulator binding example accordingly.
> 
> While at it, drop an unnecessary label and add a newline separator
> before the child node to improve readability.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] dt-bindings: regulator: qcom,usb-vbus-regulator: clean up example
      commit: d939c02359a656a624d03c6f14ccadae4a1c66ac

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


