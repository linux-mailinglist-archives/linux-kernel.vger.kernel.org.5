Return-Path: <linux-kernel+bounces-110666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A404788620C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FFBA2820CB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364EE135A4A;
	Thu, 21 Mar 2024 20:47:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68DA1350FD;
	Thu, 21 Mar 2024 20:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711054074; cv=none; b=E0DO1VdF3U+i8Ue1h1trrP5yqEOAKoRrmfmHibu7cxLmZgB9VAAkO5aIOgQL+Yq12DdPz8L96rQdrAiivA/cAlAIAtZdV+zqVc+emHytTfFifD9qXKln3XRWwL30jqyjnuYIyOjLbID25ophARIVlqLvhTAJ3iCf8rp6dicY5AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711054074; c=relaxed/simple;
	bh=4utMjzXtsiOHbAQ45wQckDJpw6gRwLA+Xt2u+hmQ/MY=;
	h=From:Subject:Date:Message-ID:To; b=qN3xskM8FDCuEhVXl3vG19u01fE7SWcBYkZVcLP9+ZGB3T08fjGBI0h/WjQIX8xFBnnC10MgMdYyV5HGHWQwMUKoYuuoMU338+S2njk4S8I+ioEWNnTMY7s7/7Y1526NmiEKgwvxC/dwZ74n1V9Sqyzp7j27FLBMvUER7hI8X8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15016C43390;
	Thu, 21 Mar 2024 20:47:53 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.22-rt27
Date: Thu, 21 Mar 2024 20:47:15 -0000
Message-ID: <171105403588.890055.3432744850569638041@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.22-rt27 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: d91f041ac62f864f74ca90f4cd3028b465e38448

Or to build 6.6.22-rt27 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.22.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.22-rt27.patch.xz


Enjoy!
Clark

