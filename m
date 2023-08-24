Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AE8786FD8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237238AbjHXNC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240448AbjHXNCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:02:16 -0400
Received: from luna.linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1F1CEE;
        Thu, 24 Aug 2023 06:02:14 -0700 (PDT)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id AFA138CC624; Thu, 24 Aug 2023 15:02:13 +0200 (CEST)
Date:   Thu, 24 Aug 2023 15:02:13 +0200
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Alexandre Courbot <acourbot@nvidia.com>,
        azkali <a.ffcc7@gmail.com>, CTCaer <ctcaer@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: bq24190_charger: Export current
 regulator
Message-ID: <ZOdU1RO0AxKmz0PY@desktop>
References: <20230824112741.201353-1-linkmauve@linkmauve.fr>
 <20230824112741.201353-3-linkmauve@linkmauve.fr>
 <f2f033a6-f552-b86f-250b-08fb298c9bb1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2f033a6-f552-b86f-250b-08fb298c9bb1@linaro.org>
Jabber-ID: linkmauve@linkmauve.fr
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 02:41:41PM +0200, Krzysztof Kozlowski wrote:
[…]
> > 
> > Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> 
> Missing SoB.

Do I need to add myself even if I didn’t change anything over what the
original author wrote?

[…]
> 
> Best regards,
> Krzysztof
> 

Thanks,

-- 
Link Mauve
