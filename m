Return-Path: <linux-kernel+bounces-167795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 990908BAF3F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C54DD1C21592
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C854747784;
	Fri,  3 May 2024 14:51:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBEB41C63;
	Fri,  3 May 2024 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714747894; cv=none; b=sjvjotYfKjVSBRvbJ3RGXt+yf2rdWSDYY5lKY2GT2vZCNYcDvjIBQND9Iy1qwmRFsKKYxFDeyRx4W+1R+GkWHGby0eyvIOACe1jOe9e88O+oA2tmcjyhc6N6C86cJWEtBFBBaYVybqUuv/k7DIlkVgYtirCBMu+5ufodbSmKFx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714747894; c=relaxed/simple;
	bh=yp3GewXITgyg+YvAHbWbv1GdOIneRZZdU5+UoPRDMBY=;
	h=From:Subject:Date:Message-ID:To; b=alBv19fifg85DQ8ajomyRYKbvLOPd0GnZ3ZnV9789gCnDbtC92RcHeBHCuz5vWNvkEBlMeyeDB9sLYp6Pvz6mSn6vRpVLkeU6LAVeKdHVBLz496ClEG0fVlfMlj3DcIQLBYQJ0yUjACoBZHYziIeUZ4t4SRy0uM9D7dXG30Xe8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5788C116B1;
	Fri,  3 May 2024 14:51:33 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.90-rt30
Date: Fri, 03 May 2024 14:50:58 -0000
Message-ID: <171474785812.865322.12738726239804946490@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.90-rt30 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: 87d93ab96eb215cf2652acf8f5277dd87dc89c4c

Or to build 6.1.90-rt30 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.90.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.90-rt30.patch.xz


Enjoy!
Clark

