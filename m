Return-Path: <linux-kernel+bounces-14174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E45CB8218C0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB51282CD2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27376AB9;
	Tue,  2 Jan 2024 09:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PRlzdS1M"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87CCCA64;
	Tue,  2 Jan 2024 09:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704186852;
	bh=qRzFsSKIk+pQYV2JVY2v2RiueDVjYFpJ/1HbxTuhDO8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PRlzdS1MUaxKxCe1Y4LfdpRXHeeZih4kmqaYSu6J8e0Ha4PDrUaU0fjssSTLPHCmz
	 uilPt+jn6U5kpZMaEMP+97+Oqg58sle1Rx9ZpQ6XZvhp7V/LN0qOVI2mnvNSCaAgVA
	 gxrYO006iI1V7GZVnQJnpNgXUc07lgrvw/LU6V2c7MYoNM7Raq+in4Zf3oruHodm2P
	 ZKPL6MyqqXalf6Bzhod18UmzSxt7tBToZo7iL1SOi7x4MnzeaYCDTLKG7F+63IJQKJ
	 Gi1nvb9mg4IVtM7WiyUeMTkztcVNAZNB1g7fBihLLlHHUl6viZ3JNXcqxIQCllUgZ/
	 O6Z9AeekhpjYA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 581C637804B2;
	Tue,  2 Jan 2024 09:14:11 +0000 (UTC)
Message-ID: <19a1c7f0-b202-4d7c-ab0a-c64f16929e19@collabora.com>
Date: Tue, 2 Jan 2024 10:14:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] dt-bindings: media: mtk-vcodec-encoder: add
 compatible for mt8186
Content-Language: en-US
To: Eugen Hristev <eugen.hristev@collabora.com>, tiffany.lin@mediatek.com,
 andrew-ct.chen@mediatek.com, matthias.bgg@gmail.com,
 linux-mediatek@lists.infradead.org
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 robh+dt@kernel.org, kernel@collabora.com, Rob Herring <robh@kernel.org>
References: <20231228113245.174706-1-eugen.hristev@collabora.com>
 <20231228113245.174706-5-eugen.hristev@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231228113245.174706-5-eugen.hristev@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 28/12/23 12:32, Eugen Hristev ha scritto:
> Add compatible for the mt8186 encoder which currently works in the same
> way as mt8183.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



