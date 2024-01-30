Return-Path: <linux-kernel+bounces-45003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D17842A39
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9D45B240A3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A9112839E;
	Tue, 30 Jan 2024 17:00:06 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8131272C4;
	Tue, 30 Jan 2024 17:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706634005; cv=none; b=bJKp5NnNAb1zNJaP7tgF14o+YjYmKfrbQTPI0aEeT/zwy/smNM38NY+pGH9m3FXFTwlmtlL7hpDJCujqD6kpZiZCHoIeLpgVKpdvj4xJEDhSxXfHkYutImtNdLvl5g+On69/jlucnDMxyKZIRUvez8XxnW2zQzQ6tRH82tBYUyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706634005; c=relaxed/simple;
	bh=2WJh7xiolJHBkaD2cGzkF3zsZN4p5AMCNX9/AYUfBmY=;
	h=From:Subject:Date:Message-ID:To; b=Q3xGuXBdJlqWTpJu7mO7JROywU63dUvgLEl3WhyJ7fx4q/o/fIBfBNY3UHFTwTpyRaDg0+AQOEhmQ1TM1hr1OaR3AP+H9WcZYvudawNmCmRLpiifFqDzXWc3l4WhLUDOsJvZhVcieRZXWOrV4WKQJcDecU0YLSfLs5igPW00osE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120B3C43399;
	Tue, 30 Jan 2024 17:00:04 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.75-rt23
Date: Tue, 30 Jan 2024 16:59:38 -0000
Message-ID: <170663397812.1314437.1686905275956809283@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.75-rt23 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: feaccee7987b202020fb8e13d33a793930a55045

Or to build 6.1.75-rt23 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.75.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.75-rt23.patch.xz


Enjoy!
Clark

