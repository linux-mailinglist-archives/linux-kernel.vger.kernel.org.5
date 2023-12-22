Return-Path: <linux-kernel+bounces-9587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFFF81C7EE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A06001F2552B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB96517993;
	Fri, 22 Dec 2023 10:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+qCJUK0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF7E17983
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 10:13:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA186C433C8;
	Fri, 22 Dec 2023 10:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703240036;
	bh=B3Fb3xaBgAJ3MicHOvgzp7hskRNgdGEtl2qTy05aZKc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G+qCJUK04/auFikiWz2Ec6e1QyGnDMaDk/BjJ6UjmfbvmdGHIVtL/xid3226FLyey
	 LZbEvlhvKqa0+cbCXc2jwqJF+BJ7IhhwGOgQBa9N+jaXHtUJUfXavuGyCVPb3xJ6uz
	 LZnTnndvZLr2kUBgkd4EiaHDIyZeSeRQwqUcyUvIuM0/Xbr6ZY3u1cZ/512MFR5AGk
	 ih5F8IZFArvpur1Gl1bwnujZa4+solwWvlXmpfGXi07qvy0CpsgQvqu7gYC/qiXKqZ
	 EwsUZEEgOnGfSipSUoZNRHq87B6J74q9BiUxifiSrvmUkSjFC9eqiYZflVuj2QCk2K
	 vZPVD2CPBystw==
Message-ID: <15424f2b-601c-44b0-83a8-19d69d7c92cf@kernel.org>
Date: Fri, 22 Dec 2023 12:13:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] phy: ti: j721e-wiz: Add SGMII support in WIZ
 driver for J784S4
Content-Language: en-US
To: Chintan Vankar <c-vankar@ti.com>, Maxime Ripard <mripard@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Sinthu Raja <sinthu.raja@ti.com>, Andrew Davis <afd@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
References: <20231221102956.754617-1-c-vankar@ti.com>
 <20231221102956.754617-2-c-vankar@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231221102956.754617-2-c-vankar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21/12/2023 12:29, Chintan Vankar wrote:
> Enable full rate divider configuration support for J784S4_WIZ_10G
> for SGMII.
> 
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

-- 
cheers,
-roger

