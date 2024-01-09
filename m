Return-Path: <linux-kernel+bounces-21413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FF6828ECF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22C1288640
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4607F3DB88;
	Tue,  9 Jan 2024 21:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iixHevGn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3063D994;
	Tue,  9 Jan 2024 21:18:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8EDC433F1;
	Tue,  9 Jan 2024 21:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704835083;
	bh=+NZsTQsvEf9IK8nHb/GQLWv+I+ECPCS9OicWOThDAlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iixHevGnsdK0EEr5KW702ylhHiEF9+1TBzoW9CgyDAx0ejgr9Rt5Yd/GpFTjxEEsg
	 ZcntjPhB03Yd5c1AjDyMeHa96nIChshfkTkCFiwKPPWCBjpRf+GK55RXABogQRGrbJ
	 /Z2YFYew4o2pGmTt7rcnPyWKiESX9vGQlUD82CK4ayHNFssssZTBCA9KXKHrCGXUcB
	 wWeJfE65M2ST+oQSyG94zKoptODrwL2lLYtSchFmiNVqkXJDZK8VotP9L/y7f2COyx
	 8uADRYHzG78Ayed+RtH8AfJUS4gnwaXQPtDsDbn7NJr2CqM93oAWb4rrORwaTxBpuF
	 YkZQwRZhdWwqA==
Received: (nullmailer pid 3236239 invoked by uid 1000);
	Tue, 09 Jan 2024 21:18:00 -0000
Date: Tue, 9 Jan 2024 15:18:00 -0600
From: Rob Herring <robh@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Cristian Marussi <cristian.marussi@arm.com>, Oleksii Moisieiev <oleksii_moisieiev@epam.com>, NXP Linux Team <linux-imx@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org, Peng Fan <peng.fan@nxp.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] dt-bindings: firmware: arm,scmi: support pinctrl
 protocol
Message-ID: <170483507980.3236179.15348360138173101058.robh@kernel.org>
References: <20240104-pinctrl-scmi-v2-0-a9bd86ab5a84@nxp.com>
 <20240104-pinctrl-scmi-v2-2-a9bd86ab5a84@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104-pinctrl-scmi-v2-2-a9bd86ab5a84@nxp.com>


On Thu, 04 Jan 2024 18:48:46 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add SCMI v3.2 pinctrl protocol bindings and example.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/firmware/arm,scmi.yaml     | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


