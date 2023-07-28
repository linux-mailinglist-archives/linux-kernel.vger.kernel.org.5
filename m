Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D572766489
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 08:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbjG1GvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 02:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbjG1Gue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 02:50:34 -0400
Received: from zg8tmty3ljk5ljewns4xndka.icoremail.net (zg8tmty3ljk5ljewns4xndka.icoremail.net [167.99.105.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01FB54483;
        Thu, 27 Jul 2023 23:50:07 -0700 (PDT)
Received: from linma$zju.edu.cn ( [42.120.103.58] ) by
 ajax-webmail-mail-app4 (Coremail) ; Fri, 28 Jul 2023 14:49:33 +0800
 (GMT+08:00)
X-Originating-IP: [42.120.103.58]
Date:   Fri, 28 Jul 2023 14:49:33 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Lin Ma" <linma@zju.edu.cn>
To:     "Jakub Kicinski" <kuba@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        razor@blackwall.org, idosch@nvidia.com, lucien.xin@gmail.com,
        liuhangbin@gmail.com, edwin.peer@broadcom.com, jiri@resnulli.us,
        md.fahad.iqbal.polash@intel.com, anirudh.venkataramanan@intel.com,
        jeffrey.t.kirsher@intel.com, neerav.parikh@intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] rtnetlink: let rtnl_bridge_setlink checks
 IFLA_BRIDGE_MODE length
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <20230727171551.28b7504d@kernel.org>
References: <20230726075314.1059224-1-linma@zju.edu.cn>
 <20230727171551.28b7504d@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <213aba20.edc73.1899b427db9.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgB3ybH+ZMNkZ01JCg--.55904W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwIIEmTAePoLZAAss+
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gdGhlcmUsCgo+IAo+IEJlY2F1c2Ugb2YgdGhlIHJlcG9zdCB0aGlzIHBhdGNoIGRpZG4n
dCBtYWtlIGl0IGluIHRpbWUgdG8gdG9kYXkncwo+IFBSIGFuZCB5b3UnbGwgaGF2ZSB0byB3YWl0
IGFub3RoZXIgd2VlayBiZWZvcmUgcG9zdGluZyB0aGUgY2xlYW51cAo+IG9mIHRoZSBkcml2ZXJz
IDooCgpHb3RjaGEgOk8KSSB3aWxsIHJlbWVtYmVyIHRvIGRvIHRoYXQgbmV4dCB3ZWVrIDspCgpS
ZWdhcmRzCkxpbg==
