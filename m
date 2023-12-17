Return-Path: <linux-kernel+bounces-2723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD43E816101
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43295B22FA1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0305027F;
	Sun, 17 Dec 2023 17:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilkY6jcp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5867C50270;
	Sun, 17 Dec 2023 17:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BF2C433D9;
	Sun, 17 Dec 2023 17:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702833723;
	bh=YGqlNiruxaT1usyju6Ip2bOyhkVAtQpq3Vl6L+4L3Kg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ilkY6jcpdfa6VqSoedx/iy7AeT2a4IEzUBY78S3O9Vly37zSXs12RrBiyK5pwrTfD
	 BS7ggiilNNaEAtXuN0GdFq2WPyU+QPFwt0t3p+egTXt1o0ylcTaJKPYh4PeenSJpt4
	 ngFsdil6/hj5A/2E9N2X1utPeHY2jKusoCbuOJcSoKLBnR6uADxiV0WWI5nTfJB2Ta
	 X6VMsBVcxTnPHvXctMRZGMuib04uoe9y0WLkC0oMKYD5da7JIaGv6+5XLQl8+TwvHj
	 dghEmCfFLN/AeeNoQmzd0kI2wjKTP4Iq7HcJpgHjyZ97KC8bPsrRuVrdn2Me3ke/67
	 ah781eQ6R0Sdg==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 0/4] arm64: dts: qcom: few improvements
Date: Sun, 17 Dec 2023 11:21:17 -0600
Message-ID: <170283349427.66089.7599164608222796886.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231213162856.188566-1-krzysztof.kozlowski@linaro.org>
References: <20231213162856.188566-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 13 Dec 2023 17:28:52 +0100, Krzysztof Kozlowski wrote:
> Changes in v2:
> 1. Previous submission included stale patch.  Resend without it. No
> actual changes, but marking it v2 for convenience.
> 
> Best regards,
> Krzysztof
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: qcom: sm8450: move Soundwire pinctrl to its nodes
      commit: 565f4d00cde3e2e7c84fc81eb72f220eb048fcf1
[2/4] arm64: dts: qcom: sm8450: drop unneeded assigned-clocks from codec macros
      commit: 39859a1206e9ec47a00e7e712c5aecb4d352e001
[3/4] arm64: dts: qcom: sm8550: move Soundwire pinctrl to its nodes
      commit: a25d2dbb68aab84a4431d382d6a21539ed6760e5
[4/4] arm64: dts: qcom: sm8550: drop unneeded assigned-clocks from codec macros
      commit: 738387a1f8fa72c0f6db3fb659c60a1ff3c5a736

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

