Return-Path: <linux-kernel+bounces-5454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C8A818AD8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F650B232B7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6541CAA3;
	Tue, 19 Dec 2023 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZmcBwYV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F531CA91;
	Tue, 19 Dec 2023 15:08:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71817C433C7;
	Tue, 19 Dec 2023 15:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702998537;
	bh=N4GQD8ADqNPm7FDKh55proalTthUwuaSs1k1cCD0hoQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=FZmcBwYVYUwPwlLmfHumP3N4U60DcquLxnncjePIixD/Hrm4K8x2/mMoLWDzwGC02
	 F3RaLvJ0J8HNMwsfpZHdltVRZL89eVwKyCLuDRqAy9FqzAM8eyCdZQYYukieVdVwwI
	 qx2NM9xKovbzQR8qx560sWqu1GPF+Av8ukj6YRwAvLEO1AqKIpEUPne0QKUzbS6f+l
	 3GIRqk3xYLqr3nmhSsXdB3jH0g47GQpGS5zoCLbvArai23PoDrYpcnKIQGE+Sn1p2F
	 D8p0YBOwsIv+Z5gHSYyVRSMvCOArTYRMSsZJu9l4+aZOHPgvRWMytcpprDop43pvKW
	 QciZf/F04Jw8g==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] wifi: rtl8xxxu: Add additional USB IDs for RTL8192EU
 devices
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231217123017.1982-1-zenmchen@gmail.com>
References: <20231217123017.1982-1-zenmchen@gmail.com>
To: Zenm Chen <zenmchen@gmail.com>
Cc: Jes.Sorensen@gmail.com, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, pkshih@realtek.com, rtl8821cerfe2@gmail.com,
 Larry.Finger@lwfinger.net, Zenm Chen <zenmchen@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170299853329.797699.11756508094408172829.kvalo@kernel.org>
Date: Tue, 19 Dec 2023 15:08:55 +0000 (UTC)

Zenm Chen <zenmchen@gmail.com> wrote:

> Add additional USB IDs found in the vendor driver from
> https://github.com/Mange/rtl8192eu-linux-driver to support more
> RTL8192EU devices.
> 
> Signed-off-by: Zenm Chen <zenmchen@gmail.com>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

4e87ca403e20 wifi: rtl8xxxu: Add additional USB IDs for RTL8192EU devices

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231217123017.1982-1-zenmchen@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


