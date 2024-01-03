Return-Path: <linux-kernel+bounces-16014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDDC823705
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3661F21FAC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EAE1D691;
	Wed,  3 Jan 2024 21:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="KTV7vW6c"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335471D687;
	Wed,  3 Jan 2024 21:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 6CA6A1C33;
	Wed,  3 Jan 2024 21:16:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6CA6A1C33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1704316564; bh=bc+dSyDYED/JD3CVYnk3pQBxWHTpxsZXlw5xthXZTso=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KTV7vW6cJLuRJmaKf6Pisb2+ILNL5iQ73IuJbgK90/L9bTbwX6gjsTdgdVXJwaP4Q
	 4rQdqCyGdFGfkfZpbgbNYLrndt/CKv3kBU6tt+1C9xfN0XDKF3+JfubXa2JvkacYOm
	 F2lKTIHVb/v2EgCoGfSe9Ghkj/5Cz62OSYs0FGb/5o8RZJYriGOdCjfik8eLKciY/5
	 uUvgeBp+FFdTgarZdYS/VHF83DrOr/N+f72esiT0ni9V96k5ZDf5MNTKTDugmXxQmL
	 +1rUJ/BfG4MvZIZxlMjV9GtIKU5NPPT25WGiMgtOOzsjBObP9dshghIlXLhu/wJ9ns
	 xWgVrbALSG2nA==
From: Jonathan Corbet <corbet@lwn.net>
To: Matthew Cassell <mcassell411@gmail.com>
Cc: linux-doc@vger.kernel.org, trivial@kernel.org,
 linux-kernel@vger.kernel.org, mcassell411@gmail.com
Subject: Re: [PATCH] Documentation/trace: Fixed typos in the ftrace FLAGS
 section
In-Reply-To: <20231223185845.2326-1-mcassell411@gmail.com>
References: <20231223185845.2326-1-mcassell411@gmail.com>
Date: Wed, 03 Jan 2024 14:16:03 -0700
Message-ID: <87cyui86ek.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matthew Cassell <mcassell411@gmail.com> writes:

> Fixed typos in the FTRACE_OPS_FL_RECURSION flag description.
>
> Signed-off-by: Matthew Cassell <mcassell411@gmail.com>
> ---
>  Documentation/trace/ftrace-uses.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

jon

