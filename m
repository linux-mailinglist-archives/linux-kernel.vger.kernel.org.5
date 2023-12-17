Return-Path: <linux-kernel+bounces-2727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FFC81610D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60E00283424
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C5D51C27;
	Sun, 17 Dec 2023 17:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8YF41GD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C46456B88;
	Sun, 17 Dec 2023 17:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07FDC433C7;
	Sun, 17 Dec 2023 17:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702833728;
	bh=1gK+OooGqBcdJotayJJaz/++swc96yzfw2fwfANLkD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m8YF41GDC0tpEKPSuE93fRdYk1fjzhVXq0PVUqGm1S5HI/powThJRjnY34q8HP56k
	 S05l9cILhDmAybBXqYetxrGisswx7kYVbWTWIS0qkJck6s/ZXGy2L+BnMyCHYskXhu
	 6HlVWvONk0BJ4G2njagxa5ycIyuwasLdIV+vwlghGL5lmB4aJFUDA4P47X2hpmpMsk
	 LZFwF5z/WIh2/vplnNSYn+K57ipVUGRRy0ETapB7FEv41hBXLpgMfmTMdXRDlmwfKr
	 PH3okzKXG8wdwJPU7UnNnztfeUka0yLtQf175PkIi2wgQlTLDeK1yXzO7P7ozzVhWG
	 TUv0qodrGL3Rg==
From: Bjorn Andersson <andersson@kernel.org>
To: cros-qcom-dts-watchers@chromium.org,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nikita Travkin <nikita@trvn.ru>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] sc7180-acer-aspire1: Add sound
Date: Sun, 17 Dec 2023 11:21:21 -0600
Message-ID: <170283349415.66089.10522260207075458789.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231205-aspire1-sound-v2-0-443b7ac0a06f@trvn.ru>
References: <20231205-aspire1-sound-v2-0-443b7ac0a06f@trvn.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 05 Dec 2023 16:48:09 +0500, Nikita Travkin wrote:
> This series adds initial sound support to Acer Aspire 1.
> 
> The following sound devices are enabled:
> - External stereo speakers
> - Headphone jack
> - Headset microphone
> - DisplayPort sound*
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: qcom: acer-aspire1: Enable RTC
      commit: 04fe8f0a68a346048f2432380a74a5e393d59a4c
[2/3] arm64: dts: qcom: acer-aspire1: Correct audio codec definition
      commit: feec9f0add432a867f23e29afcd2f7088889b8e2
[3/3] arm64: dts: qcom: acer-aspire1: Add sound
      commit: 4555798a21c973c66c8de91b58a2d0b4d0df4af3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

