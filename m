Return-Path: <linux-kernel+bounces-5520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE6D818B9D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C4551F250FB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38C81CF9C;
	Tue, 19 Dec 2023 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQco+Mtx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D25A1D522;
	Tue, 19 Dec 2023 15:53:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C73C433C9;
	Tue, 19 Dec 2023 15:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703001230;
	bh=2u2KauBAa48YgXbTuV8ltQ8J32Q6mKscN4TSL3UOF6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UQco+MtxeMSyI/PAa2Rxr9aRdAJRfxC9DHogmgaTf2ai7BC0Vcp70scanxHz6pOU3
	 jPvCUFfqguAnzF4ZTqaHRhQhBu1ucHVfVTX7GImY+FadIL8doFbVeII6HbtOIOSvmk
	 aAisCloju4FDINuQJO5uircIAujgwr30Jlaf5Oho3byRy7RrvN+e/zgSio+PBIT+De
	 AUAh7udzzRWUDOHfUmT5NbOZrMJYCpe4Q0B1PeppZFbNixffD+mFNhDpkNvM8p6l/o
	 CR1fNGCylsGzvYAzSgiZdyir7uK+sGkQJii4XwyxOr3eSQW2uUVZbMCjzC7bpNeRwJ
	 lRKhsCRG37YLQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rFcPk-0008IA-1j;
	Tue, 19 Dec 2023 16:53:48 +0100
Date: Tue, 19 Dec 2023 16:53:48 +0100
From: Johan Hovold <johan@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] dt-bindings: spmi: clean up hisilicon binding
Message-ID: <ZYG8jA64drRFL-SW@hovoldconsulting.com>
References: <20231130173757.13011-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130173757.13011-1-johan+linaro@kernel.org>

Hi Stephen,

On Thu, Nov 30, 2023 at 06:37:55PM +0100, Johan Hovold wrote:
> When reviewing the various SPMI PMIC bindings, I noticed that several
> examples were incorrect and misleading and could also use some cleanup.
> 
> This series addresses the related hisilicon SPMI controller binding.

> Johan Hovold (2):
>   dt-bindings: spmi: hisilicon,hisi-spmi-controller: fix binding
>     references
>   dt-bindings: spmi: hisilicon,hisi-spmi-controller: clean up example

I noticed that these are not yet in linux-next so sending a reminder.

Johan

