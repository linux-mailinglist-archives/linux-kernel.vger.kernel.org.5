Return-Path: <linux-kernel+bounces-16139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA31823992
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD8CFB2117E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F59A5F;
	Thu,  4 Jan 2024 00:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfyobkcQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501B836C;
	Thu,  4 Jan 2024 00:21:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B222AC433C7;
	Thu,  4 Jan 2024 00:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704327666;
	bh=s7/tvKYtmRpQ4RGIkj3jplCs9SRygwYMY7woM5z1S2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BfyobkcQk5LjTWm9KJaE0omEY1pm2n3wQPSSwQOd/xr8E6dqkT9+u3lXET6/7irZf
	 I0813MoZr/FGZ9q2sD0yyuhsIdBxxIJR5Rph4EfRQSJ2tiyR3oAdMtMLAkznQG2+Yi
	 Ft/F7C6FiCbSBi6aVke+IdWu8FrvEhLVwkdRdqG7gVQ5eDRcDlgW5huIlMO6HyRjnI
	 AF5MO3O0aRSsRDR8igy1DJglmFVAjXS0jZEwrLMd5bZLOuuOsIm1vfUxueIwuPYvUS
	 67wRNA8AeojLBsFW2L1Wb9B1/lJjPqTc/NltRTFZNSP7b6m/PLgLxD1osTV8zhnieo
	 Gip9FH4wCIdAQ==
Received: (nullmailer pid 2195519 invoked by uid 1000);
	Thu, 04 Jan 2024 00:21:03 -0000
Date: Wed, 3 Jan 2024 17:21:03 -0700
From: Rob Herring <robh@kernel.org>
To: baneric926@gmail.com
Cc: conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, Bonnie_Lo@wiwynn.com, robh+dt@kernel.org, naresh.solanki@9elements.com, billy_tsai@aspeedtech.com, corbet@lwn.net, jdelvare@suse.com, linux-hwmon@vger.kernel.org, openbmc@lists.ozlabs.org, linux@roeck-us.net, linux-doc@vger.kernel.org, kwliu@nuvoton.com, kcfeng0@nuvoton.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, DELPHINE_CHIU@wiwynn.com
Subject: Re: [PATCH v3 2/3] dt-bindings: hwmon: Add NCT7363Y documentation
Message-ID: <170432766278.2195265.1869197055341324861.robh@kernel.org>
References: <20231222013352.3873689-1-kcfeng0@nuvoton.com>
 <20231222013352.3873689-3-kcfeng0@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222013352.3873689-3-kcfeng0@nuvoton.com>


On Fri, 22 Dec 2023 09:33:51 +0800, baneric926@gmail.com wrote:
> From: Ban Feng <kcfeng0@nuvoton.com>
> 
> Adding bindings for the Nuvoton NCT7363Y Fan Controller
> 
> Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
> ---
>  .../bindings/hwmon/nuvoton,nct7363.yaml       | 63 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


