Return-Path: <linux-kernel+bounces-102389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A69D487B181
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D817E1C287EE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E4865BCC;
	Wed, 13 Mar 2024 18:56:25 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B56E57875;
	Wed, 13 Mar 2024 18:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710356185; cv=none; b=YxdyFmwPoI0wtiEi7qmnFQDd3+Y+M72D33TS6y0IRGaZYoveGmprZ+grAy1G+CTFl3aUL0HdEHAc+5Kas0dshOe3y/wTlFf2m2njmcNtM1Pb46meay86EalswBCAy73o/TkSNt8u53yHHT5dwpPZBIFkjDNRKnGLw7Ry7+Yy2I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710356185; c=relaxed/simple;
	bh=6CPhWplRKL6ZXn4Bpy9iy8veWJTpt4vVWHiQfaK2cI8=;
	h=From:Subject:Date:Message-ID:To; b=rg1R+oo/9vbCpJiUdx0piDKjO2UrAUdge+MlKPMx0QVHO5w1vjX9k34FOsBDZNcdUXStCssXyZLjRVFR1TKy5oO/o2bI01Oly/byItJ6sYXkORaZ9VVseMr8hBHoVhwpe/O3bwWwOosqU3Jz7Goe/DEa0eX2cczsiIt3dJpYSIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F9DC433C7;
	Wed, 13 Mar 2024 18:56:23 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.21-rt26
Date: Wed, 13 Mar 2024 18:55:31 -0000
Message-ID: <171035613144.245874.17454534265481939921@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.21-rt26 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: 9ddab713e5ac3cc25667f26d74b77da55149c0a9

Or to build 6.6.21-rt26 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.21.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.21-rt26.patch.xz


Enjoy!
Clark

