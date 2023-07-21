Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DA575CB24
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjGUPNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjGUPNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:13:43 -0400
X-Greylist: delayed 1189 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Jul 2023 08:13:20 PDT
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EEE635AB;
        Fri, 21 Jul 2023 08:13:19 -0700 (PDT)
Received: from linma$zju.edu.cn ( [10.181.227.232] ) by
 ajax-webmail-mail-app4 (Coremail) ; Fri, 21 Jul 2023 22:53:10 +0800
 (GMT+08:00)
X-Originating-IP: [10.181.227.232]
Date:   Fri, 21 Jul 2023 22:53:10 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Lin Ma" <linma@zju.edu.cn>
To:     "Simon Horman" <simon.horman@corigine.com>
Cc:     steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] xfrm: add NULL check in xfrm_update_ae_params
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <ZLqTe9XroSlOs+39@corigine.com>
References: <20230721014411.2407082-1-linma@zju.edu.cn>
 <ZLqTe9XroSlOs+39@corigine.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4c1a89e2.e2292.18978f0bf57.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgAHTAnWm7pkf+nPCQ--.49268W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwUDEmS54XkBxQAEsS
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWUCw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gU2ltb24sCgo+IAo+IG5pdDogaW1wZWxlbWVudGF0aW9uIC0+IGltcGxlbWVudGF0aW9u
Cj4gCj4gLi4uCgpPb29vcHMsIHNvIHNvcnJ5LiA6TwpIYXZlIHNlbnQgdGhlIHNlY29uZCB2ZXJz
aW9uIG9mIHRoaXMgcGF0Y2guIFRoYW5rcyEgSGF2ZSBhIGdyZWF0IHdlZWtlbmQuCgpSZWdhcmRz
Ckxpbg==
