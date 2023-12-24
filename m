Return-Path: <linux-kernel+bounces-10686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0271E81D8B8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 11:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 687C4282244
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 10:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9366253AF;
	Sun, 24 Dec 2023 10:33:37 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from gauss.telenet-ops.be (gauss.telenet-ops.be [195.130.132.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF765382
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
	by gauss.telenet-ops.be (Postfix) with ESMTPS id 4Sycg46ywnz4wyT7
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 11:27:44 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:2c7f:22eb:441d:ee2f])
	by albert.telenet-ops.be with bizsmtp
	id SATc2B00B38ZHRX06ATdsi; Sun, 24 Dec 2023 11:27:37 +0100
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rHLho-00DICc-Su
	for linux-kernel@vger.kernel.org;
	Sun, 24 Dec 2023 11:27:36 +0100
Date: Sun, 24 Dec 2023 11:27:36 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.7-rc7
In-Reply-To: <20231224100204.2059683-1-geert@linux-m68k.org>
Message-ID: <3fc2de68-3226-7370-813c-19ad472dc@linux-m68k.org>
References: <CAHk-=wjDbR1oNZtqTNE4n8MHbzi028JFKSCvyW88hw+0GO=P+A@mail.gmail.com> <20231224100204.2059683-1-geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Sun, 24 Dec 2023, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.7-rc7[1] to v6.7-rc6[3], the summaries are:
>  - build errors: +0/-7

The usual SH ICE crickets.

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/861deac3b092f37b2c5e6871732f3e11486f7082/ (237 out of 239 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/ceb6a6f023fd3e8b07761ed900352ef574010bcb/ (237 out of 239 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds

