Return-Path: <linux-kernel+bounces-6291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C4D8196DB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B907B240C1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E088C09;
	Wed, 20 Dec 2023 02:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNtk0TkF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC078BEB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 02:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19339C433C7;
	Wed, 20 Dec 2023 02:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703039580;
	bh=zfpztoMv6/VhejjLxbkUyaNcYXca4laObErPcQBcelQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tNtk0TkFrmHXegPbcA8EVWRSe5OdJsSbGNnHbWj2KhOXEpCJKbdyHQSBq9o2cK+w7
	 M5WfNMAMRThyPDdXbz7sd7CdqZIJ8vjhDhKCgfdglGzJt4Mit/+9OFUoFIw2DdfHBJ
	 0AMWsXpjIRXzaHhNMCln1kHp4xemGcQtq0YAh6NUH3/YXL64Ow/BpZ3sar7cwhDdTz
	 2cmcxUOfvT8UhvCp8SuyutEeWSS71L8ABnBx7U4RUnnW8Yz/2L+KRJsiPbbKRAu03l
	 fxoJsZR8YunK6lpymedfrbev42Vx17Tv3S9rBYRqeih4D4iwteTvO/0Rg5/Lkl/nqS
	 G1Oe2YoW+Cpjw==
Message-ID: <158f7fcb-e600-4bca-85b0-dcfd95366f18@kernel.org>
Date: Wed, 20 Dec 2023 10:32:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5] f2fs: show more discard status by sysfs
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com
References: <1703037598-4359-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1703037598-4359-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/12/20 9:59, Zhiguo Niu wrote:
> The current pending_discard attr just only shows the discard_cmd_cnt
> information. More discard status can be shown so that we can check
> them through sysfs when needed.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

