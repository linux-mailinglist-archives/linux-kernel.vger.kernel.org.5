Return-Path: <linux-kernel+bounces-18021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E330825750
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0D911F23841
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACB22E825;
	Fri,  5 Jan 2024 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hp8VA9bN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5757B2E650;
	Fri,  5 Jan 2024 15:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507DCC433C8;
	Fri,  5 Jan 2024 15:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704470261;
	bh=+xa3cNc4fcmH+9F+ro04yf6AD35CnnniOU6kTmbOkS4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hp8VA9bNDcKBrfceM0NBOHZYSQHq8VljuQcPiXyfQUGdtFEHvm7TQC/H4YnkN1adN
	 gP+ySw25al33GXQEhZPMR1/RlmBJfCk5zousBMQQnKREc0jL7ojHX2tcTnStcKfIcs
	 WZ0Jlz2mIWTn0v9Y/jz+6E3Khop85p8JSDS7GlO4pKYkrkqSxQ3dkHNN4HGNMLFCVm
	 3aAaOG8wJL/kt3CkQiBFb/BFlIN0J88W2xbZ/eMKtlAAy0UtL5ly5UHMlJyqSex8zt
	 +61u68ezphI+HRz3xktBfs6RsPSgsavfKzpBe8/IpRZBEfDFy/kWOaQ2dUAapcMuDl
	 flcjY5BqB0THQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20240104-tps65132-v2-1-6c77fe2f4787@apitzsch.eu>
References: <20240104-tps65132-v2-1-6c77fe2f4787@apitzsch.eu>
Subject: Re: [PATCH v2] dt-bindings: regulator: Convert ti,tps65132 to YAML
Message-Id: <170447026000.44002.12548824311139188235.b4-ty@kernel.org>
Date: Fri, 05 Jan 2024 15:57:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-5c066

On Thu, 04 Jan 2024 23:40:40 +0100, André Apitzsch wrote:
> Convert TI TPS65132 bindings from .txt to .yaml format.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] dt-bindings: regulator: Convert ti,tps65132 to YAML
      commit: 94cc3087aac4103c33c6da84c092301afd783200

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


