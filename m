Return-Path: <linux-kernel+bounces-8828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0E481BCCD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F3FE1F2586A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEB663510;
	Thu, 21 Dec 2023 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nF/GnY0i"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446A8627E0;
	Thu, 21 Dec 2023 17:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C645C433C9;
	Thu, 21 Dec 2023 17:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703178967;
	bh=n70baIvcjor/mK5/3mzrSLuCYGgvXxOtzRttt3oI4zE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nF/GnY0iQR/v5v4WY1QhEdxmtX6J/BZ7ieUxm6JRjD+Du4JZ6esROdyzX9tg7+rOu
	 mR3K+0W/r0QO7u7eBZ4GVvjNCWKXiHi+ptura7DWKVdvqDzThZdl71fK/urkOzGb5m
	 TQ32kb7B6OYB0Yrydoq4drhyECS60WXTmEQfqYc13w5jjMzcqrHuDprGeCHNr1FS1Y
	 o+Pb3glUGOucsXXtbcbUziuwAhjARC/sy4dhaK/D4jngcd2n0s2Rj3BMBoCU5w7JfO
	 RSs+3O+kxBX2Xn/TPgCz2+Bhkjqxfa2l+5iZ2F6EYGD6LQFzuYaC4qzvXsYJ0cXUrU
	 ZeguFuEFQibhQ==
From: Vinod Koul <vkoul@kernel.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231122-phy-qualcomm-eusb2-x1e80100-v2-1-3ba9a8e5ade4@linaro.org>
References: <20231122-phy-qualcomm-eusb2-x1e80100-v2-1-3ba9a8e5ade4@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: phy: qcom: snps-eusb2: Document the
 X1E80100 compatible
Message-Id: <170317896370.712473.16155097082641260373.b4-ty@kernel.org>
Date: Thu, 21 Dec 2023 22:46:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Thu, 07 Dec 2023 14:49:10 +0200, Abel Vesa wrote:
> Add the X1E80100 compatible to the list of supported PHYs.
> 
> 

Applied, thanks!

[1/1] dt-bindings: phy: qcom: snps-eusb2: Document the X1E80100 compatible
      commit: ec80c175c096eb752d581ef0aafb12ed46010b2a

Best regards,
-- 
~Vinod



