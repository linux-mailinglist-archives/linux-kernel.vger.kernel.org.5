Return-Path: <linux-kernel+bounces-17075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A818247FF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5535E28613A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA0E28DD7;
	Thu,  4 Jan 2024 18:13:43 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.lichtvoll.de (luna.lichtvoll.de [194.150.191.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A2928DB4;
	Thu,  4 Jan 2024 18:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id C6A5D863913;
	Thu,  4 Jan 2024 19:13:31 +0100 (CET)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs new years fixes for 6.7
Date: Thu, 04 Jan 2024 19:13:31 +0100
Message-ID: <6008735.lOV4Wx5bFT@lichtvoll.de>
In-Reply-To: <o7py4ia3s75popzz7paf3c6347te6h3qms675lz3s2k5eltskl@cklacfnvxb7k>
References: <o7py4ia3s75popzz7paf3c6347te6h3qms675lz3s2k5eltskl@cklacfnvxb7k>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Kent.

Kent Overstreet - 01.01.24, 17:57:04 CET:
> Hi Linus, some more fixes for you, and some compatibility work so that
> 6.7 will be able to handle the disk space accounting rewrite when it
> rolls out.

Is it required to recreate BCacheFS with updated BCacheFS tools from Git 
in order to benefit from that compatibility work or does BCacheFS 
automatically update the super block?
 
> Happy new year!

Happy New Year!

Best,
-- 
Martin



