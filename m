Return-Path: <linux-kernel+bounces-43573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5DF8415A8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCB0DB23A43
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6AD4C3D4;
	Mon, 29 Jan 2024 22:32:48 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AC24C91;
	Mon, 29 Jan 2024 22:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706567568; cv=none; b=iZ6sGhq5/ftIzazwTbWBUvSpaYBpQdrNwcWrG0Mdyj1VMny3j+9yTxq2Fkk/GUz5yZwRc4I0RqMpRnBU0wI0yN9xAQPLQYINLBywAVuKg6EUtUsHJ7DOwv9k/kH/ZJ7X3m6XMRKRsfDGMHIceCdRxeHGp6Ar/LvfvCkUNPDcbGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706567568; c=relaxed/simple;
	bh=XQo8cgj8GwW2/wffULmfs92RdH9ijjEGTusk6tvS6g4=;
	h=From:Subject:Date:Message-ID:To; b=aPnqnodOgqKYsJV9IilDKpSuutbkOyPbT1C2KSPcIjdi39Xp0rw2wjdMeVyNHSNQNJKqxep7zdoo6BF8r9qMWfLSnELcWpENwVHHOgD/JoEgBTZ11tFV8ab6AuWxPPpu3A4krbgU0bARP0AayJIfYFmHfyu4ektatOKOwgyi8bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89958C433C7;
	Mon, 29 Jan 2024 22:32:46 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.14-rt21
Date: Mon, 29 Jan 2024 22:32:08 -0000
Message-ID: <170656752857.1151094.1832357481997638169@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.14-rt21 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: 696a477de80aff6e5ae22f885fc6a354720270de

Or to build 6.6.14-rt21 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.14.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.14-rt21.patch.xz


Enjoy!
Clark


