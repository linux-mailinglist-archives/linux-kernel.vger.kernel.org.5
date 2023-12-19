Return-Path: <linux-kernel+bounces-5407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847E5818A5A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ABAEB22E8A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58ADB1C282;
	Tue, 19 Dec 2023 14:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ruAt8R1W"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B257A1B29A;
	Tue, 19 Dec 2023 14:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C91342E5;
	Tue, 19 Dec 2023 14:43:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C91342E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1702997002; bh=YYkTgLHWZWuJTe23hGQMhCHmoCL30jR2J2fVbYjLk3o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ruAt8R1Wf856UWW2dpU/U8bk4M/FnlB591heDbjGyYUyX43DyElqc8XrViVdg1GX5
	 /HMuF8JxYE9itcQn53F1GCzS32qu3l2xw014QRrPI56zNEqJS9AsRcqmrchYowCZgF
	 Eq7skEIa8ju7UNu0IbOEebWPFtaF8TdQWTX1mtkNjxzQHPNmWQHCUEkTzrpH+d0zVR
	 hV7lZJ0Hips+Zw5hHNFT8Adz0vjhdCmnznoUzmK4zpfNuKwEFasL5kLtrgWq4AVLdV
	 JbCOKXbpOqV/kg2xnOp0jHhlRlS2h38kYDAVLaS9U3aww0g2YeP2HdpQV7hQnzBnDh
	 p2ngLGR8Rf3WQ==
From: Jonathan Corbet <corbet@lwn.net>
To: "JiaLong.Yang" <jialong.yang@shingroup.cn>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>
Cc: 2738078698@qq.com, "JiaLong.Yang" <jialong.yang@shingroup.cn>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Docs/zh_CN: Fix the meaning of DEBUG to pr_debug()
In-Reply-To: <20231219070813.29161-1-jialong.yang@shingroup.cn>
References: <20231219070813.29161-1-jialong.yang@shingroup.cn>
Date: Tue, 19 Dec 2023 07:43:21 -0700
Message-ID: <87wmtai77a.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

IkppYUxvbmcuWWFuZyIgPGppYWxvbmcueWFuZ0BzaGluZ3JvdXAuY24+IHdyaXRlczoNCg0KPiBT
aWduZWQtb2ZmLWJ5OiBKaWFMb25nLllhbmcgPGppYWxvbmcueWFuZ0BzaGluZ3JvdXAuY24+DQo+
IC0tLQ0KPiAgRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vY29yZS1hcGkvcHJpbnRr
LWJhc2ljcy5yc3QgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25z
L3poX0NOL2NvcmUtYXBpL3ByaW50ay1iYXNpY3MucnN0IGIvRG9jdW1lbnRhdGlvbi90cmFuc2xh
dGlvbnMvemhfQ04vY29yZS1hcGkvcHJpbnRrLWJhc2ljcy5yc3QNCj4gaW5kZXggNTljNmVmYjNm
YzQxLi5jYWZhMDFiY2NmZjIgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRp
b25zL3poX0NOL2NvcmUtYXBpL3ByaW50ay1iYXNpY3MucnN0DQo+ICsrKyBiL0RvY3VtZW50YXRp
b24vdHJhbnNsYXRpb25zL3poX0NOL2NvcmUtYXBpL3ByaW50ay1iYXNpY3MucnN0DQo+IEBAIC0x
MDAsNyArMTAwLDcgQEAgcHJpbnRrKCnnmoTnlKjms5XpgJrluLjmmK/ov5nmoLfnmoQ6Og0KPiAg
DQo+ICDkuLrkuobosIPor5XvvIzov5jmnInkuKTkuKrmnInmnaHku7bnvJbor5HnmoTlro/vvJoN
Cj4gIHByX2RlYnVnKCnlkoxwcl9kZXZlbCgp77yM6Zmk6Z2e5a6a5LmJ5LqGIGBgREVCVUdgYCAo
5oiW6ICF5ZyocHJfZGVidWcoKeeahOaDheWGteS4i+WumuS5ieS6hg0KPiAtYGBDT05GSUdfRFlO
QU1JQ19ERUJVR2BgICnvvIzlkKbliJnlroPku6zkvJrooqvnvJbor5HjgIINCj4gK2BgQ09ORklH
X0RZTkFNSUNfREVCVUdgYCAp77yM5ZCm5YiZ5a6D5Lus5LiN5Lya6KKr57yW6K+R44CCDQo+ICAN
Cg0KVGhpcyBwYXRjaCBuZWVkcyBhbiBhY3R1YWwgY2hhbmdlbG9nLiAgQmVpbmcgaWxsaXRlcmF0
ZSBpbiBDaGluZXNlLCBJDQpjYW4ndCBtYWtlIGFueSBjb25uZWN0aW9uIGJldHdlZW4gdGhlIHN1
YmplY3QgbGluZSBhbmQgd2hhdCBoYXMgYWN0dWFsbHkNCmJlZW4gZG9uZSBoZXJlLg0KDQpUaGFu
a3MsDQoNCmpvbg0K

