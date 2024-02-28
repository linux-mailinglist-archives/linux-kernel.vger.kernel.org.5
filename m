Return-Path: <linux-kernel+bounces-84392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9B786A650
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59E57B2BE7F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D729442C;
	Wed, 28 Feb 2024 01:56:24 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D0915AF;
	Wed, 28 Feb 2024 01:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709085383; cv=none; b=YRC94Bm6m1IqjxzoiReEQeDlZQLj4Pi5+wML3kyxJE8mz0lUbhUs/o8OZGpWJ53YNhDB/AZ+iKLD7oPuDyqLxYZDUz/6VuAAYnk4TBMzdJlhXPsaItki1t6ndA2SoEmw0mcqFAVThrEy0j4Q/AD61KTpo4N+PZKBsCKhFbxXaME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709085383; c=relaxed/simple;
	bh=Q1FFzL6F9oq0dVgL1q3/EFay+ET9Y75NPQJ+uIuCDH4=;
	h=From:Subject:Date:Message-ID:To; b=mqXGFxlKVZ0Yv8ClNDOtt5mak+NrD04j0I2Hhb9y4SxPFBeLJPJoYvti/lSqMgayQPhm3sNWJA2/Y6ty2UELRDaWtN6uC1O5HWGJB+Fi9PPYEOYHbv4v5VAnkAnA09hVVEq5WuSb3A0lcRnvr/JkKVGfp+tUm+RvgPHDupRJMJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A271C433C7;
	Wed, 28 Feb 2024 01:56:22 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.79-rt25
Date: Wed, 28 Feb 2024 01:55:51 -0000
Message-ID: <170908535103.421358.4623722558350250768@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.79-rt25 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: 81e82eb9d8977f08af48d28d2e2dd4e91e838209

Or to build 6.1.79-rt25 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.79.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.79-rt25.patch.xz


Enjoy!
Clark

