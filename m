Return-Path: <linux-kernel+bounces-1277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C96814CC4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8E628A418
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A453BB35;
	Fri, 15 Dec 2023 16:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Ncyc5Jj4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EDB3BB27;
	Fri, 15 Dec 2023 16:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 6FD052ED;
	Fri, 15 Dec 2023 16:16:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6FD052ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1702656988; bh=Fd9BwtYsJaSxP7C02HmDk1eW41KYwWdVsjtC8ySaH30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ncyc5Jj4bmtnLHiGKB2bPBb5wuVQ11Bv/oSvQr3rl5nhmolMikr9aIuF530+1g97T
	 ydbnI6d0QAX/6y8/vaiuE6Fai1VSCuYDnUUk0E/3cgvaTbCwN4feDag2JjAAC7XEVa
	 zzUEssdaXDDBTHV/+fgn5QdmBRYjQQpjr+cRp+nP9c/3HMrraJwSs/oNW1DJr2ygao
	 H7oSG7NEw2sJB9FUE+J9qZy/STzQdaN5brDx4dYcvG3BmNs4Pyw7+TEy9FL+qhHDKI
	 9tIoVgkqOIfMrLhRXMkpcn1DfYhaclLG73qd3eUWOlYXXdtEqj4UyyXmfmXTAy0spK
	 uotWy/huJjEqQ==
From: Jonathan Corbet <corbet@lwn.net>
To: Rex Nie <rex.nie@jaguarmicro.com>
Cc: rdunlap@infradead.org, gregkh@linuxfoundation.org, jim.cromie@gmail.com,
 mcgrof@kernel.org, rex.nie@jaguarmicro.com, linux@weissschuh.net,
 lists@jade.fyi, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 angus.chen@jaguarmicro.com
Subject: Re: [PATCH] Documentation: fix typo in examples of
 dynamic-debug-howto.rst
In-Reply-To: <20231213073735.2850-1-rex.nie@jaguarmicro.com>
References: <20231213073735.2850-1-rex.nie@jaguarmicro.com>
Date: Fri, 15 Dec 2023 09:16:27 -0700
Message-ID: <87a5qbqw4k.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Rex Nie <rex.nie@jaguarmicro.com> writes:

> Since most examples use ddcmd alias, remove the redundant file names
>
> Signed-off-by: Rex Nie <rex.nie@jaguarmicro.com>
> ---
>  Documentation/admin-guide/dynamic-debug-howto.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

I've applied the patch, thanks.

I did change the subject line, though, since I don't think this change
really qualifies as a typo fix:

  Documentation: Remove redundant file names from examples

jon

