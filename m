Return-Path: <linux-kernel+bounces-6378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D98B8197F7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F7351C253E4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2D6125BC;
	Wed, 20 Dec 2023 05:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzVz2QyE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902D511C80;
	Wed, 20 Dec 2023 05:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF997C433C9;
	Wed, 20 Dec 2023 05:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703049256;
	bh=pyYKrBAS1Cco72BS17TJpIVFVTWv0EUCz7JHiNVMn/I=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=bzVz2QyE9S1JZsvF3vZy9JC96F7odjSa+s0Y96RfcDQ982VxjEsYJBcmU3Nfpe1EJ
	 ZqouCRqLJ2cGRTUJ/6DVAS2eBpTNiVXs1rfcPJznJ6JwWd30a5gCy7S+U5cgy6NF4/
	 Ex73yo0djfo9kMkYW/YNHDwrlkSjgglCsrr1zXNWk1Qc6dWZTcJoLXHOTm+WTO4WhJ
	 meRr19ne1kkLNvMfZEGemFH3ruU0UxYRJuftSMPdFrk3fOXZzeeWLag3d9Q81xn5Yu
	 rnCfea2/+HcezbBzgEq2ZO7m5ichhSmtMqZNFTL704f4ZQ7l68N9iCWW0UzblJUJ/5
	 qhF4PzsvLvs0w==
From: Kalle Valo <kvalo@kernel.org>
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: Larry.Finger@lwfinger.net,  linux-wireless@vger.kernel.org,
  b43-dev@lists.infradead.org,  linux-kernel@vger.kernel.org,  Abaci Robot
 <abaci@linux.alibaba.com>
Subject: Re: [PATCH net-next] wifi: b43legacy: clean up some inconsistent
 indentings
References: <20231220011209.127586-1-yang.lee@linux.alibaba.com>
Date: Wed, 20 Dec 2023 07:14:12 +0200
In-Reply-To: <20231220011209.127586-1-yang.lee@linux.alibaba.com> (Yang Li's
	message of "Wed, 20 Dec 2023 09:12:09 +0800")
Message-ID: <87r0jh317f.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yang Li <yang.lee@linux.alibaba.com> writes:

> drivers/net/wireless/broadcom/b43legacy/dma.c:178 priority_to_txring() warn: inconsistent indenting
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7783
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

wifi patches go to wireless-next, not net-next. No need to resend
because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

