Return-Path: <linux-kernel+bounces-13862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022F08213BB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 13:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E5628209E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 12:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085903D70;
	Mon,  1 Jan 2024 12:42:53 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from weierstrass.telenet-ops.be (weierstrass.telenet-ops.be [195.130.137.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26F83C17
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
	by weierstrass.telenet-ops.be (Postfix) with ESMTPS id 4T3b5Q20Tyz4x1NJ
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 13:34:18 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:80cd:b0f2:ee79:513f])
	by baptiste.telenet-ops.be with bizsmtp
	id VQaA2B0073YAfuD01QaA8A; Mon, 01 Jan 2024 13:34:10 +0100
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rKHUg-00EAv7-3m
	for linux-kernel@vger.kernel.org;
	Mon, 01 Jan 2024 13:34:10 +0100
Date: Mon, 1 Jan 2024 13:34:10 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.7-rc8
In-Reply-To: <20240101121746.384920-1-geert@linux-m68k.org>
Message-ID: <e0d7d1b-6d28-5d9a-d2f9-7ab218a1a730@linux-m68k.org>
References: <CAHk-=whbyHgacqfOJ0VU_GxB-p=Cz+xsQ6XWrAEx=gT_QO9ERg@mail.gmail.com> <20240101121746.384920-1-geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 1 Jan 2024, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.7-rc8[1] to v6.7-rc7[3], the summaries are:
>  - build errors: +10/-3

Just tbe usual SH ICE crickets.

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/610a9b8f49fbcf1100716370d3b5f6f884a2835a/ (all 239 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/861deac3b092f37b2c5e6871732f3e11486f7082/ (237 out of 239 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds

