Return-Path: <linux-kernel+bounces-167749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC0C8BAE9A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9CC282A8C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4A0154C08;
	Fri,  3 May 2024 14:12:29 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB34154455;
	Fri,  3 May 2024 14:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714745549; cv=none; b=eACo+LGsB5/4nGuGrbeq2BrTKqOPmsEEfRBkvyFBXPcVT6EKnh9PpBKgYmCFg74njX1moF9K9S4heCagKXESmy4HreI2Hs/FIzrkk1hsMc1PDAW1UzO+HtHRTRZuZMgLoeMkNiAXDQpR6JEYoIgxM+eLTFQWj9XBAaGYOtXHTYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714745549; c=relaxed/simple;
	bh=1Ylx7O1a4LVGOEvjQBYRSD713TdXxRsAdfjM6kMBaIA=;
	h=From:Subject:Date:Message-ID:To; b=XNq+K5mRA9k8z3vxwvdwxt3Qo3detFMe5W7XYXcsugLkz49uEGu7k3MDkhW5HCcBRbRi8CsjIBD/iUW6+XwQap1VTRZKCfjaBhO/7Gn2uYLub9moNk0Tkvyxugn72quaT4Ql9AZqM3on6YhQ5+DFlF48UDU+tA2JfMZdp9qSlss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAF4C2BBFC;
	Fri,  3 May 2024 14:12:28 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.30-rt30
Date: Fri, 03 May 2024 14:11:14 -0000
Message-ID: <171474547450.724318.14890809928154072107@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.30-rt30 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: cb3cfb43b523b958fd3820d7d3515eb7413a6e91

Or to build 6.6.30-rt30 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.30.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.30-rt30.patch.xz


Enjoy!
Clark

