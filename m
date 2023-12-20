Return-Path: <linux-kernel+bounces-7376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D259181A6ED
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 19:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC86286974
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD2B482F9;
	Wed, 20 Dec 2023 18:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJuZaVo+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E46482D8;
	Wed, 20 Dec 2023 18:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A2AC433C8;
	Wed, 20 Dec 2023 18:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703097122;
	bh=+W4MZSnIdFxDeoOGN4ZEea9W+NDCRvgrpYi4Ct0HJ0M=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=dJuZaVo+DSNOPKL9xLE+Z6apOJkt00w6sKsTrCHjTX1DTRPJPNGfYD6aCvL2/h/oZ
	 P+w/uL+WgRraEG0lpwDMBKoDGmGWpFT06jINne0WXPPKY87Hhdgxw9iscQ3ysweW1I
	 GtZbystadfdPjbwZnuHOVxNB5IPe+g70zRTmbbI+Iu0oynac9XVHHx9t/wyrWDCvAO
	 tr9RJ3trT5t11mQiUXVYY7EoRvYPM94PHxYtPYH+4shXN8O4SrPYLf/7k+WYkJOkzq
	 qz08cr/ODcGtMV/MPcMbM/gMKw40pg4gPixq81zOTzvzFFoGJuNRFxi7G/P72eDahU
	 xOSeASjr4qKbw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: Make QMI message rules const
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <20231217-ath12k-qmi_elem_info-const-v1-1-7ebb0de0a2b6@quicinc.com>
References: 
 <20231217-ath12k-qmi_elem_info-const-v1-1-7ebb0de0a2b6@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>,
 <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170309711908.1012170.4054276554183355555.kvalo@kernel.org>
Date: Wed, 20 Dec 2023 18:32:00 +0000 (UTC)

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> Commit ff6d365898d4 ("soc: qcom: qmi: use const for struct
> qmi_elem_info") allows QMI message encoding/decoding rules
> to be const, so do that for ath12k.
> 
> Compile tested only.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

e7ab40b73309 wifi: ath12k: Make QMI message rules const

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231217-ath12k-qmi_elem_info-const-v1-1-7ebb0de0a2b6@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


