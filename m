Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C107642D2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 02:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjG0ADt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 20:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjG0ADr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 20:03:47 -0400
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A3069C;
        Wed, 26 Jul 2023 17:03:43 -0700 (PDT)
Received: from linma$zju.edu.cn ( [10.181.249.112] ) by
 ajax-webmail-mail-app2 (Coremail) ; Thu, 27 Jul 2023 08:03:17 +0800
 (GMT+08:00)
X-Originating-IP: [10.181.249.112]
Date:   Thu, 27 Jul 2023 08:03:17 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Lin Ma" <linma@zju.edu.cn>
To:     "Jakub Kicinski" <kuba@kernel.org>
Cc:     "Nikolay Aleksandrov" <razor@blackwall.org>, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, idosch@nvidia.com,
        lucien.xin@gmail.com, liuhangbin@gmail.com,
        edwin.peer@broadcom.com, jiri@resnulli.us,
        md.fahad.iqbal.polash@intel.com, anirudh.venkataramanan@intel.com,
        jeffrey.t.kirsher@intel.com, neerav.parikh@intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rtnetlink: let rtnl_bridge_setlink checks
 IFLA_BRIDGE_MODE length
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <20230726084420.1bf95ef9@kernel.org>
References: <20230725055706.498774-1-linma@zju.edu.cn>
 <6a177bb3-0ee4-f453-695b-d9bdd441aa2c@blackwall.org>
 <7670876b.ea0b8.189912c3a92.Coremail.linma@zju.edu.cn>
 <20230726084420.1bf95ef9@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2b14aaf4.e65a0.18994a82f19.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgBnEZxFtMFk6q+iCg--.43986W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwIIEmTAePoLZAAdsP
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFrdWIsCgo+IAo+IFlvdSdsbCBuZWVkIHRvIHdhaXQgZm9yIHRoZSBwYXRjaCB0byBwcm9w
YWdhdGUgYmVmb3JlIHBvc3RpbmcuCj4gT3VyIHRyZWVzIG1lcmdlIGVhY2ggVGh1cnNkYXksIHNv
IGlmIHlvdSBwb3N0IG9uIEZyaWRheSB0aGUgZml4Cj4gc2hvdWxkIGJlIGluIG5ldC1uZXh0LgoK
Q29vbCwgSSB1bmRlcnN0YW5kIG5vdy4gVGhhbmtzIQoKUmVnYXJkcwpMaW4=
