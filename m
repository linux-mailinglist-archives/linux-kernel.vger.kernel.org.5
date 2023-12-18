Return-Path: <linux-kernel+bounces-3403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B74E4816BD4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE7441C22F73
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F80199D3;
	Mon, 18 Dec 2023 11:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GMOUuh8v"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F99E199A6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 11:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702897526;
	bh=VwWFVs1q6UKep98KZVV2dDt5BoOvo25qOrLbP5Vj6KY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GMOUuh8vMBtOs55pxBrvpJ5TcsJqxOkiw+ktasismeYhm7mZ6QeaR8cWLgKsi7VJm
	 BjIUHl6fanMx+OQJMi3j1+y5Yw4uJIjMgtdHiEkUc974V3BK5Pqm1JsPH/oivt+HPi
	 Z8RIydWD9hWDYrZ0QMlT5g+TOene1fu58onsBhsM/jYZA+YYfw3zlGYdTgdbFotWvu
	 ME0XADT1jOeJwgQB8FGO7bCsYBwRLGEre6oSbMlkmDhvfB/HJy9FlKzKysF14ip2ip
	 WACHHolZe5Q+3XhZi1uvfxpbbsDDWZhX9TV6pLFPI1Egb2c4k4PJrZdYsv8eKXq+BC
	 duFAKoew7jD0A==
Received: from [IPV6:fd00::2a:39ce] (cola.collaboradmins.com [IPv6:2a01:4f8:1c1c:5717::1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 791A23780C35;
	Mon, 18 Dec 2023 11:05:25 +0000 (UTC)
Message-ID: <2e16d209-8b19-4f6b-8406-bbe93ab05124@collabora.com>
Date: Mon, 18 Dec 2023 12:05:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mailbox: mtk-cmdq: Add CMDQ driver support for
 mt8188
Content-Language: en-US
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
 Jassi Brar <jassisinghbrar@gmail.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 Jeffrey Kardatzke <jkardatzke@google.com>,
 Jason-ch Chen <jason-ch.chen@mediatek.com>,
 Johnson Wang <johnson.wang@mediatek.com>,
 Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
 Shawn Sung <shawn.sung@mediatek.com>
References: <20231215070026.2507-1-jason-jh.lin@mediatek.com>
 <20231215070026.2507-4-jason-jh.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231215070026.2507-4-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/12/23 08:00, Jason-JH.Lin ha scritto:
> Add CMDQ driver support for mt8188 by adding its compatible and
> driver data in CMDQ driver.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


