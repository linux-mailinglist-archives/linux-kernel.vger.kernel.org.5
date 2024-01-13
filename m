Return-Path: <linux-kernel+bounces-25164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6B982C8DC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 02:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A101C21B13
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFAE18B15;
	Sat, 13 Jan 2024 01:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJ3YmOg4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3911549F;
	Sat, 13 Jan 2024 01:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F8DC433F1;
	Sat, 13 Jan 2024 01:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705110060;
	bh=pcId2LI7GQPb1KsOXAOVL9ge8ggQHivSMgPE+tdb11k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rJ3YmOg4LMNDOztpnVS2bnzFOWZZeoOtJIe+Jo+n3Gsffjs+eQY78LLvzV1coyorq
	 0N5SY6H1wTLcHWKzgZsD/JHrPTpo44aYRQYx2OhsaNFpiM14uVmxTkljUDo9SrEh0+
	 UOBVAMIgWhw7uDlEg1y8YG9qwnbaOKtwkx0tOkcT3KYYfs8Upy0RNzV5X5aOmcWBQ7
	 /pM2MXOO7IFEuDbMFK/voZwj1WNHmfAj9mPbcYbKy3KfssZqc/UGyTt0dxQIcEI2OX
	 xgEVVmLXnXIlIvkLnhZsvwrZdiH91XI+eqHErZ7QQt9jEqj1OLxr37rCoVC8zEQ8QM
	 Iq/Q6jCjIlUtw==
Date: Fri, 12 Jan 2024 19:40:57 -0600
From: Rob Herring <robh@kernel.org>
To: Christoph Winklhofer <cj.winklhofer@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, linux-serial@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-bindings: serial: allow onewire as child node
Message-ID: <170511005675.3810967.11774345392079842938.robh@kernel.org>
References: <20240106-w1-uart-v4-0-7fe1378a8b3e@gmail.com>
 <20240106-w1-uart-v4-2-7fe1378a8b3e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240106-w1-uart-v4-2-7fe1378a8b3e@gmail.com>


On Sat, 06 Jan 2024 17:02:25 +0100, Christoph Winklhofer wrote:
> The UART 1-Wire bus utilizes the Serial Device Bus to create the 1-wire
> timing patterns.
> 
> Signed-off-by: Christoph Winklhofer <cj.winklhofer@gmail.com>
> ---
>  Documentation/devicetree/bindings/serial/serial.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


