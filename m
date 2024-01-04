Return-Path: <linux-kernel+bounces-16881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAC9824556
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C503E1F22A52
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB2A24A06;
	Thu,  4 Jan 2024 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gj0hkf5S"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC313249E0;
	Thu,  4 Jan 2024 15:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8267DC433C8;
	Thu,  4 Jan 2024 15:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704383325;
	bh=FeAg1jF3t/kAkYHDbcdZeQkmtvu5zvox22CQQpOo2zQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gj0hkf5S9cyO3rNTI8nCQWjNntJE03oJcYh1i3O3Pk60DrS9rN3kAgjMWs3tD4NIB
	 PnxuhyboMpUF6lqE427NYkEn3gAuGdrkc3oncRTOmrppEghh3aqYUQwjitEBJCCEGQ
	 LF+mXJvyE+53KBofcwDpmquvEO0E5JJR+Q8MlRnlpRUdJVD0jaeF4kpfwa+N0uca40
	 N5v12pzjk4bgLJygcFb/0SRe6Zjqk9dQTI7nnTthH6jWuw+GiRRW9OZvZqOxdWu85c
	 P9G22MVOb8aYWB91RRkS4ic8tA/6yRJVN4aJiJEK7uDv4NItETpZAfh/wnd4ubUCCd
	 NQc00u+4m/cmg==
Date: Thu, 4 Jan 2024 07:48:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <shenjian15@huawei.com>, <wangjie125@huawei.com>,
 <liuyonglong@huawei.com>, <lanhao@huawei.com>, <wangpeiyang1@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 net-next 0/4] There are some features for the HNS3
 ethernet driver
Message-ID: <20240104074843.29021784@kernel.org>
In-Reply-To: <7f561916-a7ad-4189-b3a7-dfe43f9daeaa@huawei.com>
References: <20231219013513.2589845-1-shaojijie@huawei.com>
	<7f561916-a7ad-4189-b3a7-dfe43f9daeaa@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jan 2024 19:17:35 +0800 Jijie Shao wrote:
> Excuse me, This series has not been applied for a long time.
> 
> Is there any problem with this series?

It got marked as Changes Requested over the winter shutdown / break.
I'm not exactly sure why, to be honest. Please repost.

