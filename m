Return-Path: <linux-kernel+bounces-8588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C9D81B9D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178B91F22DD2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E36D36092;
	Thu, 21 Dec 2023 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuhtVTuf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CB636086;
	Thu, 21 Dec 2023 14:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE77C433C7;
	Thu, 21 Dec 2023 14:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703170167;
	bh=QvZmkfa9nsJ9c9WaTXKTbbvlPgztD+xmTVTQXhhNdEQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RuhtVTufr3KEtyr76LDmOKS8yAi6mSVaJeyaf6qXGI1OYOsZFYt+pLkz2WUfI5V0H
	 k390fzO5fJKBKxm1D3qt7aXUkobObjp36zmrVuCILJ5SKnaILuLvaCrTcxOzidL5Am
	 acArugkYbOHB8AHnON64KZHL0eSqh79niKC3nPvsALgIoZKluRzZqUJJn+0y8kKFC0
	 E4Jl1ldveLROmAKXDI4hSdrBa/eNZKgv4nnbwyv4DbzvG4oHunrwYEHAh9f3k9rA90
	 lRrZAK7YEw+LSk9MqimXxAzdwJC+SiyHG1bss1OaMVs0BZjDGpxbfSWNmwI0VNWRN7
	 l5pg1XWr8b5bQ==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>
In-Reply-To: <20231214192131.1309912-1-andriy.shevchenko@linux.intel.com>
References: <20231214192131.1309912-1-andriy.shevchenko@linux.intel.com>
Subject: Re: (subset) [PATCH v1 1/1] leds: sun50i-a100: Convert to be
 agnostic to property provider
Message-Id: <170317016487.605235.6036458810231529969.b4-ty@kernel.org>
Date: Thu, 21 Dec 2023 14:49:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Thu, 14 Dec 2023 21:21:31 +0200, Andy Shevchenko wrote:
> Convert the driver to be agnostic to the property provider.
> LEDS subsytem is not dependent on OF, so no need to make drivers
> be a such.
> 
> 

Applied, thanks!

[1/1] leds: sun50i-a100: Convert to be agnostic to property provider
      commit: 06c5206ccdb459de95bb8d558602d2a722dd4bbc

--
Lee Jones [李琼斯]


