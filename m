Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7027DFB73
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 21:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbjKBUWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 16:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKBUW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 16:22:28 -0400
X-Greylist: delayed 321 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Nov 2023 13:22:10 PDT
Received: from mail.zhcjgroup.com (unknown [182.106.224.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A953718E;
        Thu,  2 Nov 2023 13:22:10 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.zhcjgroup.com (Postfix) with ESMTP id 670E78044880;
        Thu,  2 Nov 2023 20:16:10 +0000 (UTC)
Authentication-Results: mail.zhcjgroup.com (amavisd-new);
        dkim=pass (1024-bit key) reason="pass (just generated, assumed good)"
        header.d=zhcjgroup.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zhcjgroup.com; h=
        reply-to:date:date:from:from:to:subject:subject
        :content-description:content-transfer-encoding:mime-version
        :content-type:content-type; s=dkim; t=1698956168; x=1701548169;
         bh=nPx/1UHReqfCWozVzWwkJqnzFbJuJjkeMLa1yYEN/8w=; b=Wm7TqGy3pR9A
        KiZqk+qnimEjwvjirokBBoGdJaI12+xyuTxtlvAjRXVpUVHKSz9D6mdQ5GbrFbJ1
        Bb1cB8vPxVfL01SIup1HWjsrbgvRelEJ+Mym2nOqC8AD7WBjksmfYwgojIpDARHm
        O5EDQFJ1sAJsyxf5MWYbRbcsyBQTCQE=
X-Virus-Scanned: amavisd-new at zhcjgroup.com
X-Spam-Score: 1.431
X-Spam-Level: *******
X-Spam-Status: Yes, score=7.4 required=5.0 tests=BAYES_95,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,HK_NAME_MR_MRS,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L5,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
Received: from mail.zhcjgroup.com ([127.0.0.1])
        by localhost (mail.zhcjgroup.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MN2J9lDZIRmx; Fri,  3 Nov 2023 04:16:08 +0800 (CST)
Received: from [192.168.0.111] (unknown [41.113.0.229])
        by mail.zhcjgroup.com (Postfix) with ESMTPA id DBE92804487D;
        Fri,  3 Nov 2023 04:15:55 +0800 (CST)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: MY SUBJECT/ EXCLUSIVE PARTNERSHIP PROPOSAL
To:     Recipients <hc@zhcjgroup.com>
From:   "Mr. Godwin Emmanuel" <hc@zhcjgroup.com>
Date:   Thu, 02 Nov 2023 22:15:38 +0200
Reply-To: godwinemmanuel4@outlook.com
Message-Id: <20231102201610.670E78044880@mail.zhcjgroup.com>
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: zhcjgroup.com]
        *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [182.106.224.187 listed in list.dnswl.org]
        *  3.0 BAYES_95 BODY: Bayes spam probability is 95 to 99%
        *      [score: 0.9857]
        *  0.0 RCVD_IN_MSPIKE_L5 RBL: Very bad reputation (-5)
        *      [182.106.224.187 listed in bl.mailspike.net]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [godwinemmanuel4[at]outlook.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  1.0 HK_NAME_MR_MRS No description available.
        *  0.8 RDNS_NONE Delivered to internal network by a host with no rDNS
        *  0.0 RCVD_IN_MSPIKE_BL Mailspike blocklisted
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Hope you are fine. I'm Godwin Emmanuel from Artesian, UK. Our company
needs a supply vendor for the regular supply of raw materials to our
company. If interested in undertaking the project, reply back, for details.
Regards,
Godwin Emmanuel
Email;godwinemmanuel4@outlook.com
