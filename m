Return-Path: <linux-kernel+bounces-26389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C87182DFF2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D98BD282BE0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994D518E1C;
	Mon, 15 Jan 2024 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AbyVG+SX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4DC18E08;
	Mon, 15 Jan 2024 18:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3864BC433F1;
	Mon, 15 Jan 2024 18:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705343428;
	bh=tkYJ9gQwmCP0qyHH75s39GTT5QsnaTeS1ps1TaLKpJI=;
	h=From:To:Cc:Subject:Date:From;
	b=AbyVG+SX7HYZteuFzjzrNY9x9HnQblcfw8QQIKNMJw9SQm3BGn16rTCMxjiN0Nsq1
	 p7zvja8nvjKiwu/o0nqUJHVbjCwNfwo16G6/H+/3ADudU5G4GFDl+AWRox2/Q/62zG
	 p/9aTHYsCN1Oj0Kh70GFr14TFUoUf4g9wCcfHg+4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.12
Date: Mon, 15 Jan 2024 19:30:21 +0100
Message-ID: <2024011521-herbicide-shun-187e@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.12 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile         |    2 +-
 fs/nfsd/nfsctl.c |   31 +++++++++++++++++--------------
 fs/nfsd/nfsd.h   |    7 -------
 3 files changed, 18 insertions(+), 22 deletions(-)

Greg Kroah-Hartman (1):
      Linux 6.6.12

Jeff Layton (1):
      nfsd: drop the nfsd_put helper


