Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3489C769503
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjGaLgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjGaLgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:36:12 -0400
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BFEC3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 04:36:08 -0700 (PDT)
X-ASG-Debug-ID: 1690803363-086e23186a03700001-xx1T2L
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx1.zhaoxin.com with ESMTP id 6fSYFuG0DOj3xpgP (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 31 Jul 2023 19:36:03 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Mon, 31 Jul
 2023 19:36:03 +0800
Received: from [10.32.65.162] (10.32.65.162) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Mon, 31 Jul
 2023 19:36:01 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Message-ID: <b2b5c3ef-cfda-ea22-b1d4-ad2865a53769@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.32.65.162
Date:   Mon, 31 Jul 2023 19:36:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] ALSA: hda: Zhaoxin: Add HDAC PCI IDs and HDMI Codec
 Vendor IDs
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH] ALSA: hda: Zhaoxin: Add HDAC PCI IDs and HDMI Codec
 Vendor IDs
To:     Takashi Iwai <tiwai@suse.de>
CC:     <perex@perex.cz>, <tiwai@suse.com>,
        <pierre-louis.bossart@linux.intel.com>,
        <zhangyiqun@phytium.com.cn>, <peter.ujfalusi@linux.intel.com>,
        <broonie@kernel.org>, <chenhuacai@kernel.org>,
        <cezary.rojewski@intel.com>, <siyanteng@loongson.cn>,
        <amadeuszx.slawinski@linux.intel.com>, <evan.quan@amd.com>,
        <jasontao@glenfly.com>, <kai.vehmanen@linux.intel.com>,
        <ranjani.sridharan@linux.intel.com>, <mkumard@nvidia.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>,
        <LeoLiu-oc@zhaoxin.com>
References: <20230731055932.4336-1-TonyWWang-oc@zhaoxin.com>
 <87v8e0bjx4.wl-tiwai@suse.de>
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
In-Reply-To: <87v8e0bjx4.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.32.65.162]
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1690803363
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 3707
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.112119
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/31/23 15:48, Takashi Iwai wrote:
> On Mon, 31 Jul 2023 07:59:32 +0200,
> Tony W Wang-oc wrote:
>> @@ -1044,6 +1044,16 @@ void azx_stop_chip(struct azx *chip)
>>  }
>>  EXPORT_SYMBOL_GPL(azx_stop_chip);
>>  
>> +static void azx_rirb_zxdelay(struct azx *chip, int enable)
> 
> It'd be helpful to have a brief function description.  It doesn't do
> any delaying but flip something instead, right?

Yes, you are right.
This function expects to implement two functions: Adjust the priority of
write cycles for KX-5000 and delay some time. Now its only implement the
first function.

> 
>> +{
>> +	if (chip->remap_diu_addr) {
>> +		if (!enable)
>> +			writel(0x0, (char *)chip->remap_diu_addr + 0x490a8);
>> +		else
>> +			writel(0x1000000, (char *)chip->remap_diu_addr + 0x490a8);
> 
> Avoid magic numbers, but define them.
> 

Got it.
This solution operate the register inside the GPU witch do not belong to
HDAC. So will evaluate this patch method again.

>> @@ -1103,9 +1113,14 @@ irqreturn_t azx_interrupt(int irq, void *dev_id)
>>  			azx_writeb(chip, RIRBSTS, RIRB_INT_MASK);
>>  			active = true;
>>  			if (status & RIRB_INT_RESPONSE) {
>> -				if (chip->driver_caps & AZX_DCAPS_CTX_WORKAROUND)
>> +				if ((chip->driver_caps & AZX_DCAPS_CTX_WORKAROUND) ||
>> +					(chip->driver_caps & AZX_DCAPS_RIRB_PRE_DELAY)) {
>> +					azx_rirb_zxdelay(chip, 1);
>>  					udelay(80);
> 
> Calling it here looks a bit misleading, especially because it's paired
> with a later call.  Better to put another if block that matches with
> both calls consistently.
> 
Ok.

>> +				}
>>  				snd_hdac_bus_update_rirb(bus);
>> +				if (chip->driver_caps & AZX_DCAPS_RIRB_PRE_DELAY)
>> +					azx_rirb_zxdelay(chip, 0);
> 
> I meant this one.
> 
>> @@ -145,6 +146,7 @@ struct azx {
>>  
>>  	/* GTS present */
>>  	unsigned int gts_present:1;
>> +	void __iomem *remap_diu_addr;
> 
> This is a completely different thing, give some comment.
> 
Its belong to GPU MMIO.

> 
>> +static int azx_init_pci_zx(struct azx *chip)
>> +{
>> +	struct snd_card *card = chip->card;
>> +	unsigned int diu_reg;
>> +	struct pci_dev *diu_pci = NULL;
>> +
>> +	diu_pci = pci_get_device(PCI_VENDOR_ID_ZHAOXIN, 0x3a03, NULL);
>> +	if (!diu_pci) {
>> +		dev_err(card->dev, "hda no KX-5000 device.\n");
>> +		return -ENXIO;
>> +	}
>> +	pci_read_config_dword(diu_pci, PCI_BASE_ADDRESS_0, &diu_reg);
>> +	chip->remap_diu_addr = ioremap(diu_reg, 0x50000);
>> +	dev_info(card->dev, "hda %x %p\n", diu_reg, chip->remap_diu_addr);
>> +	return 0;
> 
> Missing pci_dev_put()?
> 
Yes.

>> @@ -1360,6 +1385,10 @@ static void azx_free(struct azx *chip)
>>  	hda->init_failed = 1; /* to be sure */
>>  	complete_all(&hda->probe_wait);
>>  
>> +	if (chip->driver_type == AZX_DRIVER_ZHAOXINHDMI) {
>> +		azx_free_pci_zx(chip);
>> +	}
> 
> Superfluous parentheses.
> 
>> @@ -1876,6 +1906,10 @@ static int azx_first_init(struct azx *chip)
>>  		bus->access_sdnctl_in_dword = 1;
>>  	}
>>  
>> +	chip->remap_diu_addr = NULL;
>> +	if (chip->driver_type == AZX_DRIVER_ZHAOXINHDMI)
>> +		azx_init_pci_zx(chip);
> 
> No error check?  It doesn't look too serious even if the driver
> continues to load, though.
> 
>> --- a/sound/pci/hda/patch_hdmi.c
>> +++ b/sound/pci/hda/patch_hdmi.c
>> @@ -4501,6 +4501,8 @@ static int patch_gf_hdmi(struct hda_codec *codec)
>>  	return 0;
>>  }
>>  
>> +static int patch_zx_hdmi(struct hda_codec *codec) { return patch_gf_hdmi(codec); }
> 
> Don't put in a single line.
> Or, if it's the very same function, you can rather call patch_gf_hdmi
> directly in the table.
> 

Ok.
> 
> thanks,
> 
> Takashi
