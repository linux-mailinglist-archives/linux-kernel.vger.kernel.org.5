Return-Path: <linux-kernel+bounces-8829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DB081BCD0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD38D1F25621
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A16164A8E;
	Thu, 21 Dec 2023 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcwOcOKQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D3E627ED;
	Thu, 21 Dec 2023 17:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5666AC433C7;
	Thu, 21 Dec 2023 17:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703178972;
	bh=dxEbVMJEAumXA4t6D/iYlDbzjYMIA1g1CxEnpZ7zp8w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TcwOcOKQzLBFZ6Y5Ps9hGkUfnobfhGpLA63YLNorJfU1yH6ZZl+58ro1yy1CxwFUY
	 FudmUWfp6sD31ZdGEUd+ey/dnwqPcL69+fHvMZP1z0GZH+cnmAgm0UuJiuAtB1WL5i
	 kh7Xfe2NbTzhvJrLARltxAJadc9tx5rNjG7A9V0H+TUyhsmVp7qbLPjPhqTl/dq4jB
	 CB5XJmSv9SCaXi5W9IaLpbzVOFp9zDhPM7lmjzPkeFJB79NDfbZKA3OwYryymnB/xS
	 IfWFxkqAPmNSkK2ugoPKadrFDzwDz2Vbit24CHlwd2E7ztTjxtlXceNzQD91ybi/EW
	 H592XDA01Zj3g==
From: Vinod Koul <vkoul@kernel.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Johan Hovold <johan@kernel.org>, Abel Vesa <abel.vesa@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231201-x1e80100-phy-combo-v1-0-6938ec41f3ac@linaro.org>
References: <20231201-x1e80100-phy-combo-v1-0-6938ec41f3ac@linaro.org>
Subject: Re: [PATCH 0/2] phy: qcom-qmp-combo: Add support for X1E80100
 platform
Message-Id: <170317896798.712473.6042759009383174563.b4-ty@kernel.org>
Date: Thu, 21 Dec 2023 22:46:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Thu, 07 Dec 2023 15:16:40 +0200, Abel Vesa wrote:
> This patchset adds support for the USB/DP combo PHYs found on X1E80100
> platform and documents its compatible string.
> 
> It depends on the v6 N4 register offsets added by the following patchset:
> https://lore.kernel.org/all/20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v3-0-dfd1c375ef61@linaro.org/
> 
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy: Document X1E80100 compatible
      commit: f11aeb9d49632afc7abd9dfea6bcf5b3dd8addc1
[2/2] phy: qcom-qmp-combo: Add x1e80100 USB/DP combo phys
      commit: d7b3579f84f74e0f7d88d180d4e15c679786b648

Best regards,
-- 
~Vinod



