Return-Path: <linux-kernel+bounces-8824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B1381BCC1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E1EB2862C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C51E59924;
	Thu, 21 Dec 2023 17:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdSCBCOb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D273858213;
	Thu, 21 Dec 2023 17:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA09AC433C8;
	Thu, 21 Dec 2023 17:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703178950;
	bh=kvAImrMB2BLFEbE4tN+YXRJKctb+m1F/aV1dMuU9wzs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QdSCBCOb88u04vdEqFMyZzTa4QCQxPnjRPxuXFZARaGszL6Gi6Vg/x2zrEbL0i5iz
	 4/6yTdiVUG+9T1snRTak9PfErpumLjVhEUoaotUbQhi/jWC3B9ziSs1LpdTNt5PXjD
	 WzOGd/wVJk59C068xNmoSn+PHdlnF+WYgTR2ydbO17BelMyXIhbuwkM2PkpFDq/ZSm
	 ZmCxNwE8jh/wk0b3wdciYnRdcNBScsoF2zuOAoVRkap4YDlAqvWwhKeiXxLxX4AnPx
	 OSYFSA4c8J84anDOvN9twhA4XhvVQ1wDuo+/H8kDckKTApi8Kz5Czx/7jJkR6bliy8
	 CmoC6R2a+fmdA==
From: Vinod Koul <vkoul@kernel.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan+linaro@kernel.org>, 
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: stable@vger.kernel.org
In-Reply-To: <20231218130553.45893-1-krzysztof.kozlowski@linaro.org>
References: <20231218130553.45893-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy: fix
 path to header
Message-Id: <170317894553.712473.7175140339294979943.b4-ty@kernel.org>
Date: Thu, 21 Dec 2023 22:45:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Mon, 18 Dec 2023 14:05:53 +0100, Krzysztof Kozlowski wrote:
> Fix the path to bindings header in description.
> 
> 

Applied, thanks!

[1/1] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy: fix path to header
      commit: 21a1d02579ae75fd45555b84d20ba55632a14a19

Best regards,
-- 
~Vinod



