Return-Path: <linux-kernel+bounces-27374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D003982EEDE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 725D5B23014
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD781BC2C;
	Tue, 16 Jan 2024 12:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMximzzA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8231B97C;
	Tue, 16 Jan 2024 12:23:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74FD0C433C7;
	Tue, 16 Jan 2024 12:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705407780;
	bh=qJeF0QupdVph/4ADySJ3CnvcNj7AZtCl9Ege8tvHEP4=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=MMximzzAL1Md58R4H797IpGCcSTu/ZbQaD59DXfXyddUllmq/fE4Z3vVuE99GpbCQ
	 6ZA9ITo3/HFGvvLrGgz57/e3uCDs2+1JIkbMT2sr5ufHdG1vEtc/gYmmZOW4GZYERK
	 bRWHNTV5tJfT6J4OWTnBseG46bah33FvBH8di9dJRhaau96u56GBjeylmNJmc0Foqe
	 /QVwMWNi+o+rnxZepEOHPMTA/Mu2S4RApw3eNAF+OQIvJllQeI5xLd0oDGclofVDUQ
	 wJ4uX3WBbyM3vOkpZNyaHg9zPbDf17LH2vGVzcBUHs5vdC0S6Rrj9gIL/H9InMThQQ
	 cL8KdKkw2Yybw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: document HAL_RX_BUF_RBM_SW4_BM
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <20240111-document-hal_rx_buf_rbm_sw4_bm-v1-1-ad277e8ab3cc@quicinc.com>
References: 
 <20240111-document-hal_rx_buf_rbm_sw4_bm-v1-1-ad277e8ab3cc@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath11k@lists.infradead.org>,
 <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170540777761.1846129.10373492994129239501.kvalo@kernel.org>
Date: Tue, 16 Jan 2024 12:22:59 +0000 (UTC)

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> Commit 7636c9a6e7d7 ("wifi: ath11k: Add multi TX ring support for WCN6750")
> added HAL_RX_BUF_RBM_SW4_BM to enum hal_rx_buf_return_buf_manager. However,
> as flagged by the kernel-doc script, the documentation was not updated:
> 
> drivers/net/wireless/ath/ath11k/hal.h:689: warning: Enum value 'HAL_RX_BUF_RBM_SW4_BM' not described in enum 'hal_rx_buf_return_buf_manager'
> 
> So update the documentation. No functional changes, compile tested only.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

9666ad011992 wifi: ath11k: document HAL_RX_BUF_RBM_SW4_BM

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240111-document-hal_rx_buf_rbm_sw4_bm-v1-1-ad277e8ab3cc@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


