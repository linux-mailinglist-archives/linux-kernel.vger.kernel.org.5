Return-Path: <linux-kernel+bounces-6232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF16819631
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D5A2879BD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0099F612A;
	Wed, 20 Dec 2023 01:24:04 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9BC5246;
	Wed, 20 Dec 2023 01:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 0DF0A808F;
	Wed, 20 Dec 2023 09:23:57 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 20 Dec
 2023 09:23:56 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 20 Dec
 2023 09:23:52 +0800
From: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To: <conor@kernel.org>
CC: <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<jisheng.teoh@starfivetech.com>, <krzysztof.kozlowski+dt@linaro.org>,
	<krzysztof.kozlowski@linaro.org>, <leyfoon.tan@starfivetech.com>,
	<linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
	<linux@roeck-us.net>, <robh+dt@kernel.org>, <samin.guo@starfivetech.com>,
	<wim@linux-watchdog.org>, <xingyu.wu@starfivetech.com>
Subject: Re: [PATCH v4 1/1] dt-bindings: watchdog: starfive,jh7100-wdt: Add compatible for JH8100
Date: Wed, 20 Dec 2023 09:23:45 +0800
Message-ID: <20231220012345.17791-1-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231219-hankering-console-7de049490dab@spud>
References: <20231219-hankering-console-7de049490dab@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX072.cuchost.com
 (172.16.6.82)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

On Tue, 19 Dec 2023 15:43:07 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Mon, Dec 18, 2023 at 11:37:38PM +0800, Ji Sheng Teoh wrote:
> > On Mon, 18 Dec 2023 15:41:37 +0100
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >  =20
> > > On 18/12/2023 15:27, Ji Sheng Teoh wrote: =20
> > > >>
> > > >> I have real doubts that you ever tested your entire solution
> > > >> with this binding. Where is the DTS?
> > > >>   =20
> > > >=20
> > > > Currently, the DTS is still in internal and yet to upstream as
> > > > it depends on [1].   =20
> > >=20
> > > Yeah, so you send untested code which cannot work or pass tests.
> > > If you do not test your code, we need to be able to at least
> > > verify it, so send your DTS. Otherwise I cannot trust that this
> > > works at all.=20
> > Will submit it with DTS once things have cleared up.
> > Thanks for the comment.  =20
>=20
> [1] is not going to applied for a while since the SoC doesn't actually
> exist yet and is pre-tapeout on an FPGA. I would just send the dts
> patch adding the watchdog alongside the series, or else you'll be
> waiting for quite a while. Or even link to the node on github or
> whatever.
>=20

Ok, will add the watchdog dts alongside this series and mention its
dependency on [1]. Thanks.

