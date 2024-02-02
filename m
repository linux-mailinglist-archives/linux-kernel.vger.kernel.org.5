Return-Path: <linux-kernel+bounces-50493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A2E8479D8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6A03B21FB4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F2280628;
	Fri,  2 Feb 2024 19:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0cTufgc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509CD15E5AC;
	Fri,  2 Feb 2024 19:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706903016; cv=none; b=G3TQDRwXSDPRkr/V6/Ch/WcHH5EDEwzQ5mAz6dmW8gAcKVy1VjDdz5GhMBCYgHmD+c7Y3VYmPJ2eZYYHGhzWpMIxecF4iv2wCHetQ1jKKNBAyr3ApERpyQVWlaW5AvAhe/g6viLRiCVMuXMmjkKyFKmSbsgWy5Fjdw7w0gIfv/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706903016; c=relaxed/simple;
	bh=7AQ1NisE8h7M3azLdVTWRKwE+nDbvKHU5IfF9aqyy2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E95wzpBsyH81/ZPZoiXYIXg3q8QS40ZfMbDsuTmcPYJ2s7OAFgGUYb1Al5RM9fgWhg21cSzk2dPjRiQ/yW4HEA2sB1zXWOUHvqypuSI/EAm00U2kSBxnMsNKtsNJgnw86INl8JKZzJ5aZ41kt2cBZemfQ7bgdh+8CakN2hWo7ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0cTufgc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF40C43394;
	Fri,  2 Feb 2024 19:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706903016;
	bh=7AQ1NisE8h7M3azLdVTWRKwE+nDbvKHU5IfF9aqyy2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h0cTufgc0nQf3PkqeSzM+9KDN4/N94FCSqpmatbPHGn8Ti1SPnRFd1tsvnvaLeOAB
	 jxVr9eLRkowT2lNhv52Lp5mYKdR/ABpBpZ9YN/ylDn9J134VH5/d284LIwdOy1kUgv
	 SFyRXXOJJYcvquk2yUVM2hZZpgmMgKQGM+p02b3OBShuayLsFNCDXG97u/ejWf89c0
	 jW1sPUO5Ji7e/HdkX91JpKmv6XFzDwRL+DIXh2Nahjx65eryoUwHd6D54eVph7pKuT
	 psojOgGBMUgj7vQQT2pzEV++FxE28XzGZm/mYzvcUWVAypeH6WxUKC3DFRwQ7Th6sp
	 XIiFp3QlyjeEw==
Date: Fri, 2 Feb 2024 13:43:34 -0600
From: Rob Herring <robh@kernel.org>
To: Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc: devicetree@vger.kernel.org, vigneshr@ti.com, robh+dt@kernel.org,
	nm@ti.com, krzysztof.kozlowski+dt@linaro.org, srk@ti.com,
	conor+dt@kernel.org, brgl@bgdev.pl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm: ti: Update maintainers list
Message-ID: <170690301354.846180.4796168503995884734.robh@kernel.org>
References: <20240131092043.28829-1-r-gunasekaran@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131092043.28829-1-r-gunasekaran@ti.com>


On Wed, 31 Jan 2024 14:50:43 +0530, Ravi Gunasekaran wrote:
> Update the list with current maintainer of TI's davinci
> platforms.
> 
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
> Added Acked-by after discussing with Bartosz over mail.
> 
>  Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


