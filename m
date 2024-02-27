Return-Path: <linux-kernel+bounces-84186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 940B386A371
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C6EC1C233BA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F3656461;
	Tue, 27 Feb 2024 23:17:31 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD0555E44;
	Tue, 27 Feb 2024 23:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075851; cv=none; b=NvoeqnaZEMx4bRKHQstXy6/F1OashJEjlC6xmZRkEi4foHgJMenxokH+6y8ZmYVxa665Na2YcX+MNLKpmaHxkz90evTllUoYRbf6tHccU2+yvtkeqkWmhsnD3gBCdt+vX85dMJS6na4dthMsXQYql5iIK5FHWigG/RNbBT5GCPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075851; c=relaxed/simple;
	bh=jrgwgayxFH+j/G1PzbshSNnEGnY4kDPWfb/Qv0N1X4E=;
	h=From:Subject:Date:Message-ID:To; b=tKayiT0l/2IY9CN7HsB8H0I0GyidLRt0iH8JQyrRD05ydvpWvU/Xz0geqCQBFSR3v4NdyAlpU5AttTrDF5cWSxjb5APGA/Q0phX71EPO5bpBWLpgPbREZSIN23ybliXWRctGcUnfUh4Bs+oT9BaEqXo9GfnIDKUvlVnUwq5Q1uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB583C433C7;
	Tue, 27 Feb 2024 23:17:30 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.18-rt23
Date: Tue, 27 Feb 2024 23:16:10 -0000
Message-ID: <170907577025.277403.1497604783256978900@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.18-rt23 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: fc3c8f4093aa9e32e67a51ba5eebd7338195b746

Or to build 6.6.18-rt23 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.18.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.18-rt23.patch.xz


Enjoy!
Clark


