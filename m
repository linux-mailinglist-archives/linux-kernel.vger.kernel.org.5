Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6682806307
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 00:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346627AbjLEXiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 18:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjLEXiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 18:38:20 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0161122
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 15:38:25 -0800 (PST)
Received: from [100.75.103.134] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: padovan)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5DADD660715D;
        Tue,  5 Dec 2023 23:38:22 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701819504;
        bh=2CZFIUejLgdcAX8+486gEwTLlC8kPQFmxUo3clcFhOU=;
        h=Date:To:Cc:From:Subject:From;
        b=QL73S9sPuUGuwn8rgNhwsp5GOmkxycaNKPeOkMyQidqpwQbiE/JNzCs3NSW+Ij7GC
         +yQOFy7FX0TbxHGTknKAifrhee+GfAwm3gmHQkXf+3wbX5N4XJNho1Bn5LhXygwcZv
         I7K+/f3M6CWNUkkhZJ7jzHgA6gnMCEc3K9eyjdc9mEDlfwOWNnall6ZRCmUzgROtRp
         MWK/nuMZ2P3AwKkDSa8Qp1HhF+oK2sQISDFP9aMZmDMweL50JMvfCBUYafhGHYlFi7
         OPncCX+T2iUqldZE8Lwi7dJwtPpYBtRPc0svFsd0Bmr/k5pxEmxrX/Ns1NE0slG4RE
         x5FLyfqQeeEkQ==
Message-ID: <5d48c1fa-d577-6f4c-5d3c-37884053e1a9@collabora.com>
Date:   Tue, 5 Dec 2023 20:38:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernelci@lists.linux.dev" <kernelci@lists.linux.dev>,
        "automated-testing@lists.yoctoproject.org" 
        <automated-testing@lists.yoctoproject.org>,
        "kernelci-webdashboard@groups.io" <kernelci-webdashboard@groups.io>
Cc:     =?UTF-8?Q?Jo=c3=a3o_Bertacchi?= <joaobertacchi@profusion.mobi>,
        Ricardo Dourado <ricardo.dourado@profusion.mobi>
From:   Gustavo Padovan <gustavo.padovan@collabora.com>
Subject: KernelCI is designing a new Web Dashboard: we want your feedback!
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

TL;DR: KernelCI engaged with an UX speacialist vendor to design a new 
web dashboard to show our test results data. If you want to give your 
feedback, let us know. We still have a few spots for UX interviews!


As we shared previously, we are in the process of designing a new Web 
Dashboard for KernelCI. As you may know, at same time, we are putting 
together a new core infra to replace our legacy and limited system.

Ultimately, we will have a CI pipeline that allows tests to be run not 
only in KernelCI labs but outside of it too, but with test results 
contributed back to the already available common database. Then on top 
that, we want to have a powerful dashboard to help the community 
evaluate the test results in the best manner possible.

You can read our blog post for a quick summary of the UX redesign 
project: https://kernelci.org/blog/posts/2023/ux-analysis/

We have just started the first phase with the UX team interviewing 
kernel maintainers and other users of KernelCI.

If you are interested in providing your feedback just reply to this 
email or reach out to me directly. We will try to accommodate everyone 
that is interested.

Regards,

- Gus (as Project Manager for the KernelCI project)

-- 
Gustavo Padovan
Kernel Lead

Collabora Ltd.
Platinum Building, St John's Innovation Park
Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

