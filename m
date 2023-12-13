Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EC980C404
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbjLKJMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbjLKJMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:12:14 -0500
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E60FDF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:12:19 -0800 (PST)
X-ASG-Debug-ID: 1702285935-1eb14e538e2fbd0001-xx1T2L
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx2.zhaoxin.com with ESMTP id RYURT7GT3wc4xNmH (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 11 Dec 2023 17:12:15 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Dec
 2023 17:12:08 +0800
Received: from [192.168.1.204] (125.76.214.122) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Dec
 2023 17:11:47 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Message-ID: <7355325f-6038-49ca-8280-114352a5a4ac@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 192.168.1.204
Date:   Mon, 11 Dec 2023 17:11:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Extend PCI root port device IDs for Zhaoxin
 platforms
To:     Bjorn Helgaas <helgaas@kernel.org>
X-ASG-Orig-Subj: Re: [PATCH] PCI: Extend PCI root port device IDs for Zhaoxin
 platforms
CC:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <CobeChen@zhaoxin.com>,
        <TonyWWang@zhaoxin.com>, <YeeLi@zhaoxin.com>, <Leoliu@zhaoxin.com>
References: <20231201155320.GA518898@bhelgaas>
From:   LeoLiu-oc <leoliu-oc@zhaoxin.com>
In-Reply-To: <20231201155320.GA518898@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [125.76.214.122]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1702285935
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1548
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.117936
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/12/1 23:53, Bjorn Helgaas 写道:
> On Fri, Dec 01, 2023 at 08:09:42PM +0800, LeoLiu-oc wrote:
>> From: leoliu-oc <leoliu-oc@zhaoxin.com>
>>
>> Add more PCI root port device IDs to the
>> pci_quirk_zhaoxin_pcie_ports_acs() for some new Zhaoxin platforms.
> 
> Can you please add a note about the plan to deal with this for future
> devices, e.g., something like "future Zhaoxin devices now in
> development will advertise an ACS Capability as described in the
> PCIe spec"?
> 
> The point of quirks is to work around hardware that is broken or
> doesn't conform to the spec in some way.  We have to add quirks when
> broken hardware is already in the field, but we should have a plan to
> fix newer devices so they don't require quirks.
> 
Okay, note will be added in the next version.

Sincerely,
Leoliu-oc
>> Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
>> ---
>>   drivers/pci/quirks.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index ea476252280a..db74f8f07096 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -4709,7 +4709,7 @@ static int  pci_quirk_zhaoxin_pcie_ports_acs(struct pci_dev *dev, u16 acs_flags)
>>   	switch (dev->device) {
>>   	case 0x0710 ... 0x071e:
>>   	case 0x0721:
>> -	case 0x0723 ... 0x0732:
>> +	case 0x0723 ... 0x073b:
>>   		return pci_acs_ctrl_enabled(acs_flags,
>>   			PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
>>   	}
>> -- 
>> 2.34.1
>>
