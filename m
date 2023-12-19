Return-Path: <linux-kernel+bounces-5068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1BE818635
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45B781F22E66
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4EA1640B;
	Tue, 19 Dec 2023 11:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QH5d/8zH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A16B18634;
	Tue, 19 Dec 2023 11:18:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9B8C433C7;
	Tue, 19 Dec 2023 11:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702984737;
	bh=Qo03vyXdW7F4uUNSw3Fdacxi8RM9846AC7Ddh6naNlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QH5d/8zH3zl+DcY3uXwrstlgJ95682qV32ULzGgcK1tIhO7HGokN3epDpO8f/38B9
	 D16PTtMuSEBfneoKkQkGDAfvaNLUEgj85EScab+KU6p2URcaNKFeL7Oicerzx7vlqm
	 eIoFdDksUsDFN7Kz/zIi6sVifFeFRwaEfZUdZQO9gZI2itAubKL/qTRVMyHZH6mZ/E
	 Z3sHT3mQMEZ949bmwiGFgi728mRTjV3V+TERDx9+fUxt5x1T1eEd+gNGykrUgucVp6
	 RocBFVrkh39cnHAGAK+gNIkVRfI6jVvsBBR6jbv58Eb5boFEvaFVbJh9PGzqj+ug1O
	 5zPznOF0E05wA==
Date: Tue, 19 Dec 2023 11:18:52 +0000
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, lanhao@huawei.com, wangpeiyang1@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 net-next 3/4] net: hns3: dump more reg info based on
 ras mod
Message-ID: <20231219111852.GJ811967@kernel.org>
References: <20231219013513.2589845-1-shaojijie@huawei.com>
 <20231219013513.2589845-4-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219013513.2589845-4-shaojijie@huawei.com>

On Tue, Dec 19, 2023 at 09:35:12AM +0800, Jijie Shao wrote:
> From: Peiyang Wang <wangpeiyang1@huawei.com>
> 
> Dump more reg info base on ras mod before reset, which is useful to
> analyze the ras error.
> 
> Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


