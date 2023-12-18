Return-Path: <linux-kernel+bounces-3404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1FA816BD5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 623D11C22F91
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F861A286;
	Mon, 18 Dec 2023 11:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kBmOc8Ur"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD4E199B2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 11:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702897528;
	bh=xnwCF2ST5oBXkKdgDZLeNPOzu1UJmbO078KVru0GHvg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kBmOc8UrX2F9SGb5DkjPOHFiqVbCCtF+icoH7RsYrUgg5D2biS+nZLs5KM3FwVumb
	 uB4fq0zm1Ne5xsHmddD9AiJKGH2eR3dkvqlx+wRtt3b4KrwR4C51gOPXN4g5bO0b7O
	 jOqHO1GFqXLA/PJ9vNOQMZuF0HpZ3KUdoXFrJNZRFaThxaM22PIUjJb6qYhV8ib8ql
	 xEHNT1BRR2zYwXuBGsY9/QLA29Is+BNhmZOoahsfFC/srpijX7gwCdoQk4GTIOcjVu
	 UZqatJOoinvMq4R3xY2GDwj84jyeHeRQgUxghE+RaqcWNScilIx/9XAcKhg9Pq7Wbz
	 Oeuhk27LsxuOA==
Received: from [IPV6:fd00::2a:39ce] (cola.collaboradmins.com [IPv6:2a01:4f8:1c1c:5717::1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9861D37814A3;
	Mon, 18 Dec 2023 11:05:27 +0000 (UTC)
Message-ID: <10fd4fef-e71a-44bc-b80a-a4801e730039@collabora.com>
Date: Mon, 18 Dec 2023 12:05:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mailbox: mtk-cmdq: Rename gce_plat variable with
 SoC name postfix
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
 <20231215070026.2507-2-jason-jh.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20231215070026.2507-2-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/12/23 08:00, Jason-JH.Lin ha scritto:
> Rename gce_plat variable postfix from 'v1~v7' to SoC names.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



