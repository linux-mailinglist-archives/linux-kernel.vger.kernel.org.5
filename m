Return-Path: <linux-kernel+bounces-13262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D7C820234
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 23:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFD72B223D7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 22:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071F814AA3;
	Fri, 29 Dec 2023 22:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UimzQt6O"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5347814A99;
	Fri, 29 Dec 2023 22:41:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE13EC433C7;
	Fri, 29 Dec 2023 22:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703889701;
	bh=S5d7o63SwOTJODxuZFgpFPE0I1rr4P82IuuaDndsnU4=;
	h=Subject:From:To:Date:From;
	b=UimzQt6Oha8dkz2nb/GErASwBMDZCgifsLCweVok0JpBTf1eFaY5U4kvWqbjMcl98
	 f+0gzF8gwf5h7LawN/GiQdnX/vM1p0Y8R2LaeCuF2BPBEEoAZvT/BHU4V4/b+TTzqK
	 NGJKap8RmaTYkOQ9mpMgpaxAj2piUTxK09yM/Fhthe744vLu7fyNP1i+xtYx2jHaOP
	 hl0HcTKxSBPIpx9pEN4MPECIkF6cJWJ6f3P1gkfXpW1CpvKbMUZI24VNrnNgsNDQl3
	 E+4weT+CD8lVwRFDEnSvwGdIQvw9zDbVuPH/SwTsp+5e9TKqgXj63bEFGZnYVXPV9l
	 NpCL2yeoNaK1A==
Message-ID: <ba5a84795f9a448d32b8cc0f8615adab740d7ed5.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.264-rt88
From: Tom Zanussi <zanussi@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-users
 <linux-rt-users@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>, John
 Kacur <jkacur@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Daniel Wagner <wagi@monom.org>, Clark Williams
 <williams@redhat.com>,  "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 Tom Zanussi <zanussi@kernel.org>
Date: Fri, 29 Dec 2023 16:41:39 -0600
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello RT Folks!

I'm pleased to announce the 5.4.264-rt88 stable release.

This release is just an update to the new stable 5.4.264
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: 85a5b7a100a390e8fe3c65dc6de6fb9b487f8fcd

Or to build 5.4.264-rt88 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.264.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.264-rt8=
8.patch.xz


Enjoy!

   Tom



