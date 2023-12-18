Return-Path: <linux-kernel+bounces-3187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C06E8168B2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED2E1C223EC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB7C111B5;
	Mon, 18 Dec 2023 08:51:40 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A3C111A3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:1c58:2452:9c5e:ccf6])
	by laurent.telenet-ops.be with bizsmtp
	id PkrW2B001182r2K01krWSR; Mon, 18 Dec 2023 09:51:30 +0100
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rF9LV-00CaTm-Vq
	for linux-kernel@vger.kernel.org;
	Mon, 18 Dec 2023 09:51:29 +0100
Date: Mon, 18 Dec 2023 09:51:29 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.7-rc6
In-Reply-To: <20231218083931.80857-1-geert@linux-m68k.org>
Message-ID: <60f6b30-ee31-6ea5-4550-3465a3e4d612@linux-m68k.org>
References: <CAHk-=wi17USyiO=G0yDXP62eqU3V6x3ck0HcnVMPKHNPsBP_ig@mail.gmail.com> <20231218083931.80857-1-geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 18 Dec 2023, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.7-rc6[1] to v6.7-rc5[3], the summaries are:
>  - build errors: +11/-1

The usual SH ICE crickets.

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/ceb6a6f023fd3e8b07761ed900352ef574010bcb/ (237 out of 239 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/a39b6ac3781d46ba18193c9dbb2110f31e9bffe9/ (238 out of 239 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds

