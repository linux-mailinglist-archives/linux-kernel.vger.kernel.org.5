Return-Path: <linux-kernel+bounces-3402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA2B816BD3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69DD11F23046
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE67199CA;
	Mon, 18 Dec 2023 11:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="rvDJnTcZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7752199B0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 11:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702897526;
	bh=xwDmKS7uJEVRbmf2Y+FVkHsZ8nVWAj7tspkmAezbR+Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rvDJnTcZyYhbPnxOoJ887HRdx+BQ4k5hq2tP3JkfEvQv32sY4xNEojnFhRBjF7B2X
	 c6pdC1DTADv939XtEZm6JjZVT9sHVOKbCRty0aIjmYkG3mF6SK7gOS48F14rddcalg
	 QBc8n7YVdLXbFY4iccIwt3j0Ue7yLXY9W64FP9P8JUiVxBHyeNuorusxj7mv0utRF9
	 kbgFQ8rM43tQSBMODYyDbGy/QsXGUeEiqlFP5sPoKrFMvbE2e/Anlr5Kt/zAnVDKVX
	 LHeSL6Z3HZIkQ7D/5df8PpU9pm59rAiwy3j+9RlSJFZF7R8qG+mB4ifHXiBb/pB9H9
	 OQ4U1eOkF6GWQ==
Received: from [IPV6:fd00::2a:39ce] (cola.collaboradmins.com [IPv6:2a01:4f8:1c1c:5717::1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0E94B37813F7;
	Mon, 18 Dec 2023 11:05:26 +0000 (UTC)
Message-ID: <0ff37f8a-5531-46cc-b078-60843bb753a2@collabora.com>
Date: Mon, 18 Dec 2023 12:05:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mailbox: mtk-cmdq: Sort cmdq platform data by
 compatible name
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
 <20231215070026.2507-3-jason-jh.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231215070026.2507-3-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/12/23 08:00, Jason-JH.Lin ha scritto:
> Sort cmdq platform data according to the number sequence of
> compatible names.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



