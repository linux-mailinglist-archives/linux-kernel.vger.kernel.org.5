Return-Path: <linux-kernel+bounces-14206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2EE821915
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B63B81F22409
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A56C8F5;
	Tue,  2 Jan 2024 09:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="b6DbzbvN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B8CD287;
	Tue,  2 Jan 2024 09:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704188937;
	bh=OvE2/2zTZsB0BNc3HMIYvB2Llo/yQBobBLmB7wWDyHk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b6DbzbvNyNJ7nJhUWCan2k47HMceMhwuKEP2hUhQ+4gblfG93fG9ewp4xphSWF+vL
	 vm9aUhV48RopRuY7L8eOjuXaR7PtBc8nln1iHWIEuTZaxY9cHmz9lqnFsli4pOFdMj
	 Zx/SzYVIG0Rt//XHiACwkR+9DVJZSG8MFdZC+df1o2wN3+TkL4J8+ZhYN2zoJ9yzv8
	 c9lbEtHOicuvhDctF6yJJRlFniUj7WnMvrqiNcFcZVbyHGaNNE6uFZ6mbe2dN1cQGN
	 i/dxyzD55KFP4FPnRdUdAV3/8s7VMvEwWS0zmQQ3c25qh22Q6CYcqIj21xP6PO3LaB
	 sVc+CdtMet7uA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 33C5C37813DB;
	Tue,  2 Jan 2024 09:48:57 +0000 (UTC)
Message-ID: <ae25ecf0-51fc-476c-879b-14b5bc52ad4e@collabora.com>
Date: Tue, 2 Jan 2024 10:48:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] soc: mediatek: mtk-socinfo: Add driver for getting
 chip information
Content-Language: en-US
To: William-tw Lin <william-tw.lin@mediatek.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20231222080739.21706-1-william-tw.lin@mediatek.com>
 <20231222080739.21706-3-william-tw.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231222080739.21706-3-william-tw.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 22/12/23 09:07, William-tw Lin ha scritto:
> Add driver for socinfo retrieval. This patch includes the following:
> 1. mtk-socinfo driver for chip info retrieval
> 2. Related changes to Makefile and Kconfig
> 
> Signed-off-by: William-tw Lin <william-tw.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



