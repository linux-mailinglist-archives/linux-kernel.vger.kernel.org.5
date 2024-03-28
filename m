Return-Path: <linux-kernel+bounces-123654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 287A7890C44
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC69C1F24E19
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE6613B583;
	Thu, 28 Mar 2024 21:09:01 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF7713AD18;
	Thu, 28 Mar 2024 21:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711660140; cv=none; b=pLjgTcxIxtcz9ETUvCxPMhmYNCoDBep+/FgJoNxcOBtxcMJwepyNF5i/YK772bLidY0+kaJM+QLy0DIMK4xsTdzayCS74JaB6tx3XRZAmLkQkT6fSPdQD8hlqiRh4YcbMn38GkEM3If0aNkZQfokhvYHeEjsTCm0OtbtpHSuk0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711660140; c=relaxed/simple;
	bh=52261gAZIeWIOI8uQ0q9VIbpFohHJgL7wuuVXjbzEd0=;
	h=From:Subject:Date:Message-ID:To; b=rZqfSod4SQNchOdMuQZo8fZw+deUahelGxQtCSFqoKlqYOyvDu5uQaQXXLHyC/m7rXLGhkggsO4FWbEhxGscBJEAmsZHxbrCEruRFKrGmBiXNLrBH1O2dzQWyZAH6SriDI6DW5gLBuLZM38RuDVUvAmCrjOcNz9vTl9YUmz4Rys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E08DC433F1;
	Thu, 28 Mar 2024 21:09:00 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.83-rt28
Date: Thu, 28 Mar 2024 21:08:27 -0000
Message-ID: <171166010706.1375217.11208818212116841475@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.83-rt28 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: c88639fef1f2a6e8da6d4c5b6a9b07a3bd0a6cc7

Or to build 6.1.83-rt28 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.83.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.83-rt28.patch.xz


Enjoy!
Clark


