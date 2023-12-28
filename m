Return-Path: <linux-kernel+bounces-12484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6972781F57C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 08:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ED481F225E6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A7A441B;
	Thu, 28 Dec 2023 07:27:34 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AAA3D62;
	Thu, 28 Dec 2023 07:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(636801:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Thu, 28 Dec 2023 15:27:02 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.27; Thu, 28 Dec
 2023 15:27:02 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1258.27 via Frontend
 Transport; Thu, 28 Dec 2023 15:27:02 +0800
Date: Thu, 28 Dec 2023 15:27:02 +0800
From: ChiYuan Huang <cy_huang@richtek.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Uwe
 =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] RTQ6056: Add compatible for the same chip family
Message-ID: <20231228072702.GA14434@linuxcarl2.richtek.com>
References: <cover.1703734994.git.cy_huang@richtek.com>
 <ccc8081b-d7cb-44c2-b579-6e4a97a2168d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ccc8081b-d7cb-44c2-b579-6e4a97a2168d@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Dec 28, 2023 at 08:16:40AM +0100, Krzysztof Kozlowski wrote:
> On 28/12/2023 04:51, cy_huang@richtek.com wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> > 
> > *** Resend for the '--thread' config in 'git format-patch'.
> 
> Resending the same after you receive feedback means you entirely bypass
> that feedback. Don't do this. Ever.
> 
Got it. I'm just trying to figure out why Jonathan said the thread cannot be found in
lore.kernel.org. Eventually I found that's the 'thread' option.

When sending v2 patch series, I think I won't forget it in the future.

Not inteneded to bypass the whole suggestion or feedback.

Sorry for that.

> Best regards,
> Krzysztof
> 

